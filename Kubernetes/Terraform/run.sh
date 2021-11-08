#! /bin/bash

# Initialize terraform - checks, downloads and installs required modules
terraform init

# Plans the deployment - what needs to be created/removed and plans out a provisioning plan based on resource dependencies
terraform plan -out tfplan


terraform apply -auto-approve tfplan