#!/bin/bash

# Create Meteor Bundle, Build Docker Image and Push to ECR
# Supply tag as command line argument

IMAGE_NAME="omono-mongo-stream"

if [ -z "$1" ]
then
  echo "Missing Tag Argument"
  exit
fi

eval $(aws ecr get-login --no-include-email)

mkdir bundle
cp -R ../package.json ../server.js ../lib ./bundle

aws s3 cp ../config/config-demo.json s3://omono-demo-config/$IMAGE_NAME/config-v$1.json
aws s3 cp ../config/config-hbs.json s3://omono-hbs-config/$IMAGE_NAME/config-v$1.json
aws s3 cp ../config/config-production.json s3://omono-production-config/$IMAGE_NAME/config-v$1.json

docker build -t $IMAGE_NAME:$1 .
docker tag $IMAGE_NAME:$1 421370285444.dkr.ecr.eu-west-1.amazonaws.com/$IMAGE_NAME:$1
docker push 421370285444.dkr.ecr.eu-west-1.amazonaws.com/$IMAGE_NAME:$1
