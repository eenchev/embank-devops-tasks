import os
import sqlalchemy

from datetime import datetime
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials

# Project ID for listing network data
project = os.environ['GCP_PROJECT_ID']

# GCP Service Account Auth
credentials = GoogleCredentials.get_application_default()
service = discovery.build('compute', 'v1', credentials=credentials)

# DB Connection
db_user = os.environ['DB_USERNAME']
db_pass = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']
db_host = os.environ['DB_HOST']
host_args = db_host.split(':')
(db_hostname, db_port) = (host_args[0], int(host_args[1]))

db = sqlalchemy.create_engine(sqlalchemy.engine.url.URL.create(
    drivername='postgresql+pg8000',
    username=db_user,
    password=db_pass,
    host=db_hostname,
    port=db_port,
    database=db_name,
    ))

db.dialect.description_encoding = None


def init_storage_table(db):
    with db.connect() as conn:
        conn.execute('CREATE TABLE IF NOT EXISTS networks ( id BIGINT NOT NULL, name VARCHAR(255) NOT NULL, subnetworks JSON, last_fetched timestamp NOT NULL, PRIMARY KEY (id) );'
                     )


def fetch_project_networks():
    networks = []

    resource_request = service.networks().list(project=project)
    while resource_request is not None:
        response = resource_request.execute()
        for network in response['items']:
            networks.append(network)

        resource_request = \
            service.networks().list_next(previous_request=resource_request,
                previous_response=response)

    return networks


def main(request):
    init_storage_table(db)

    networks = fetch_project_networks()

    db_metadata = sqlalchemy.MetaData()
    db_metadata.reflect(bind=db)

    insert_table = db_metadata.tables['networks']

    with db.connect() as conn:
        for network in networks:
            stmt = \
                sqlalchemy.dialects.postgresql.insert(insert_table).values(id=network['id'
                    ], name=network['name'],
                    subnetworks=network['subnetworks'],
                    last_fetched=datetime.now())

            do_update_stmt = \
                stmt.on_conflict_do_update(index_elements=['id'],
                    set_=dict(name=stmt.excluded.name,
                    subnetworks=stmt.excluded.subnetworks,
                    last_fetched=stmt.excluded.last_fetched))
            conn.execute(do_update_stmt)

    return 'OK'
