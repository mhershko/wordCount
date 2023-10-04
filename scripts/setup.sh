#!/bin/bash

# Define variables
AWS_DEFAULT_REGION="eu-central-1"
AWS_ACCOUNT_ID="820983956723"
DOCKER_USERNAME="*****"
LOCAL_DOCKER_HUB_ACCESS_TOKEN="*****"
CODEBUILD_RESOLVED_SOURCE_VERSION="1"
IMAGE_NAME="word-count-app-v1"
ECR_REPO_URL="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
CONTAINER_NAME="word-count-app"

# Retrieve the Docker Hub access token from AWS Secrets Manager
# LOCAL_DOCKER_HUB_ACCESS_TOKEN=$(aws secretsmanager get-secret-value --region $AWS_DEFAULT_REGION --secret-id DockerHubAccessToken2 | jq -r .SecretString | jq -r .DOCKER_HUB_ACCESS_TOKEN)

# Pre-build phase
echo "Logging in to Amazon ECR"
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$CONTAINER_NAME

#echo "Logging in to Docker Hub"
docker login --username $DOCKER_USERNAME -p *****

COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
IMAGE_TAG=${COMMIT_HASH:=latest}

# Build phase
echo "Build started on $(date)"
echo "Building the Docker image"
docker build -t $IMAGE_NAME:latest .
docker tag $IMAGE_NAME:latest $ECR_REPO_URL/$CONTAINER_NAME:latest

# Post-build phase
echo "Build completed on $(date)"
echo "Pushing the Docker image"
docker push $ECR_REPO_URL/$CONTAINER_NAME:latest

