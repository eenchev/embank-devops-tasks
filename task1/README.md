# EMBank Devops Tech Challenge PART 1

## Requirement
You have been asked to create a web site. As a proof of concept, it will be sufficient that you
demonstrate a website that displays text (e.g. *Lorem Ipsum*
https://en.wikipedia.org/wiki/Lorem_ipsum) and an image on a single home page.
You can create your own application but can also use an open source or community
software, such as Wordpress (https://wordpress.org); or Keystone (http://keystonejs.com);
(or even use static content).

This proof of concept is to demonstrate the technical feasibility of hosting, managing and
scaling the platform and is not about content.

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
* Connect real domain property to Cloud Run service
* Setup HTTP(S) load balancing, to enable Cloud CDN or serve traffic from multiple regions
* Optimize Docker container, so it is leaner and cold starts (scaling to 0 and up) are possible
