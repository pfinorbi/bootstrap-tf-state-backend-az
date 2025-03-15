# Bootstrap OpenTofu Remote State in Azure Blob

This document outlines the steps to set up an OpenTofu state backend in an Azure blob container using OpenTofu IaC templates.

## Prerequisites

- Ensure you have the Azure CLI (`az`) installed on your system.
- Ensure you have OpenTofu (`tofu`) installed on your system.

## Steps

1. **Log in to Azure**  
   Use the following command to log in to Azure interactively:
   ```bash
   az login --use-device-code
   ```

2. **Set the Subscription ID for OpenTofu**  
   Export the subscription ID as an environment variable:
   ```bash
   export TF_VAR_subscription_id=$(az account show --query id --output tsv | tr -d "\r")
   ```

3. **Initialize and Apply the `tfstate-backend` Module**  
   Navigate to the `tfstate-backend` directory. Initialize and apply the OpenTofu configuration to create the storage account that will store the state:
   ```bash
   cd tfstate-backend
   tofu init && tofu apply
   ```

4. **Reinitialize OpenTofu to Move Local State to Remote Backend**  
   Run the initialization command again to migrate the local state to the newly created remote backend:
   ```bash
   tofu init
   ```

5. **Delete Local State Files**  
   Remove the local state files:
   ```bash
   rm terraform.tfstate terraform.tfstate.backup
   ```

6. **Test the Backend Configuration**  
   Verify that the backend is correctly configured by running an OpenTofu plan:
   ```bash
   tofu plan
   ```

7. **Store Outputs for Later Use (Optional)**  
   Export the outputs from the OpenTofu configuration as variables:
   ```bash
   resource_group_name=$(tofu output -raw resource_group_name)
   storage_account_name=$(tofu output -raw storage_account_name)
   container_name=$(tofu output -raw container_name)
   ```

8. **Return to the Root Directory**  
   Navigate back to the root directory:
   ```bash
   cd ..
   ```

## Configure a Sample OpenTofu Module with Remote Backend (Optional)

This part describes how to configure an OpenTofu module to use the remote Azure blob backend created in the previous steps.

1. **Add Remote Backend Configuration**  
   Navigate to the `sample` directory and create the backend configuration file using the following commands:
   ```bash
   cd sample

   cat << BACKEND > backend.tf
   terraform {
     backend "azurerm" {
       resource_group_name  = "$resource_group_name"
       storage_account_name = "$storage_account_name"
       container_name       = "$container_name"
       key                  = "sample.terraform.tfstate"
       use_azuread_auth     = true
     }
   }
   BACKEND
   ```

2. **Run Initialization to Configure the Backend**  
   Initialize the OpenTofu backend:
   ```bash
   tofu init
   ```

3. **Apply the Configuration**  
   Apply the OpenTofu configuration:
   ```bash
   tofu apply
   ```

4. **Destroy the Sample Resources**  
   Destroy the resources to clean up:
   ```bash
   tofu destroy
   ```