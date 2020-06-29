
# Django-test project

This small project comprises a simple installation of latest Django and points directly to the included admin app. It allows to deploy it to a existing AWS Fargate cluster by pushing the exact Docker image version and by using runserver.

# DISCLAIMER

This project was done for educational purposes. Don't expect everything to run in one go. The AWS infrastructure needs to be already in place. There are many parts left behind and assumptions, so this project shouldn't be considered best practice just yet.


## Requirements.
- Linux OS. Tested over Ubuntu 18
- Make
- Python3.8. Will probably work on older versions but untested.
- AWSCli 2 with configured credentials
- Docker CE, with your dev-user added to `docker`group.


## Create the local dev environment.
> make ready-dev

## Build local image and tag it
> make docker-build-image

## Run the local container. Map container 8000 port to localhost:8000 via interface bridge
> make docker-run

## Tag the remote image
> make docker-tag-remote

## Login into the AWS ECR registry
> make docker-login

## Push local image into remote AWS ECR
> make docker-push-image
