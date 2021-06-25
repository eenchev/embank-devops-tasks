# EMBank Devops Tech Challenge PART 1

## Requirement
This is a challenge where you can showcase your technical skills and the considerations
which you make when performing devops and infrastructure tasks. Your solution may be as
simple or complex as you like, provided it meets the requirements below, and will serve as a
discussion point when you come in to meet us. You should not need to spend more than
two or three hours on the challenge.

## Architecture
This repository contains Spring Boot application, together with the Terraform scripts to serve it on Google Cloud Run.

## How to run

1. Build container and push to gcr. 
```
gcloud builds submit --tag gcr.io/PROJECT_NAME/loremapp:1.0.0
```
Make sure you are logged in your project (gcloud auth login). Edit provider info file, so it points to authenticated project (**terraform/provider.vars.tf**)

2. Navigate tor terraform folder and run
```
terraform apply
```

## Scaling
This service utilizes Cloud Run's  autoscaling pattern. Both horizontal and vertical scaling is handled automatically, with no need to manage instance groups and load balancers.

Horizontal
- use **autoscaling.knative.dev/maxScale** and **autoscaling.knative.dev/minScale** parameters

Vertical
- use **container_concurrency** parameter
- use resources' **requests** and **limits** parameter

See [Terraform docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service)

## TODOs and improvements
* Use Terraform to setup Cloud Build for the repository. This will allow for CI/CD process.
* Setup testing and include it in Cloud Build process.
* Connect real domain property to Cloud Run service and setup TLS secured (HTTPS) connection.
