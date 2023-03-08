# Flask API Application with DB Connection Status Endpoint

## Introduction

This application is build in Flask with endpoint /live to provide mysql DB connection status.
If connection succeed it shows `Well Done` otherwise if any issue it shows `Maintenance` with DB error.

To support the application deployment, code is written in terraform.

Application would be deployed in Azure `App Service` as docker image with `Azure Mysql` DB, having option of enabling VNET connection between them for security.

## Architecture and Application Output


![Architecture Diagram](/Images/Architecture.png "Architecture")


![DB Connection Working](/Images/flaskapi.png "DB Connection")


![DB Connection Error](/Images/error.png "DB Connection ")


## CI/CD

Image is being automatically build on PR creation to master through github action  and pushed to dockerhub on PR approval.(Currently since no reviewer present it is pushed on PR creation)
Terraform run is not automated as it needs azure credentials for authentication. Otherwise a Github action could be written for terraform plan during PR creation and apply after PR approval.









