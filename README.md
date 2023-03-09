# Flask API Application with DB Connection Status Endpoint

## Introduction

This application is build in Flask with endpoint /live to provide mysql DB connection status.
If connection succeed it shows `Well Done` otherwise if any issue it shows `Maintenance` with DB error.

To support the application deployment, code is written in terraform.

Application would be deployed in Azure `App Service` as docker image with `Azure Mysql` DB, having option of enabling VNET connection between them for security.

## Architecture and Application Output


![Architecture Diagram](/Images/Architecture.png "Architecture")

**Architecture Diagram**

![DB Connection Working](/Images/flaskapi.PNG "DB Connection")

**DB Connection**

![DB Connection Error](/Images/error.PNG "DB Connection Error")

**DB Connection Error**

## CI/CD

Image is being automatically build on PR creation to master through github action  and pushed to dockerhub on PR approval.(Currently since no reviewer present it is pushed on PR creation)
Terraform run is not automated as it needs azure credentials for authentication. Otherwise a Github action could be written for terraform plan during PR creation and apply after PR approval.


## Terraform Deployment

### Prerequisite

1. To store secrets Azure KeyVault needs to be created from where secrets can be fetched. Below secrets needs to be stored in KeyVault.
 * SQLUSERNAME (e.g. value testshrey@servername)
 * PASSWORD = (Any 16 digit random string)

### Argument Reference

#### Required

The following arguments are required:

- `location`            - Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
- `prefix`              - This variable defines the company name prefix used to build resources.
- `sku_name`            - he SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1.
- `create_vnet`         - Enable this to create vnet and subnet for appservice and webapp for connection.
- `docker_image`        - Docker repo from where to pull docker image.
- `docker_image_tag`    - Docker Image tag to pull.
- `mysql-version`       - Specifies the version of MySQL to use. Valid values are 5.7, or 8.0. Changing this forces a new resource to be created.
- `mysql-sku-name`      - Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation. Possible values are B_Gen4_1, B_Gen4_2, B_Gen5_1, B_Gen5_2, GP_Gen4_2, GP_Gen4_4, GP_Gen4_8, GP_Gen4_16, GP_Gen4_32, GP_Gen5_2, GP_Gen5_4, GP_Gen5_8, GP_Gen5_16, GP_Gen5_32, GP_Gen5_64, MO_Gen5_2, MO_Gen5_4, MO_Gen5_8, MO_Gen5_16 and MO_Gen5_32.
- `geo_redundant_backup_enabled` - Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. 
- `mysql-storage`       - Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs.
- `keyvaultname`        - Name of the keyVault from where secrets needs to be pulled. (**`Note:` Azure Key Vault should pre-created**)
- `resourcegroupvault`  - ResourceGroup of the pre-created Key Vault.
- `dbname`              - Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created.
- `vnetrange`           - The address space that is used the virtual network. 
- `subnetrangesql`      - The address prefixes to use for the subnet.
- `websiteport`         - Port on which website needs to run. Set to 5000 Currently.






