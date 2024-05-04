Azure OpenAI Deployment with Content Filter and Blocklist
=========================================================

This Bicep module deploys an Azure OpenAI model with a custom content filter and a blocklist.

Usage
-----

1.  Clone the repository: git clone <https://github.com/aymenfurter/terraform-aoai-deployment-blocklist-sample.git> cd openai-deployment
2.  Log in to your Azure account using the Azure CLI: az login
3.  Set the target Azure subscription: az account set --subscription <subscription-id>
4.  Modify the `main.bicep` file in the root directory with your desired configuration.
5.  Add your blocklist items to the `main.bicep` file in the modules directory.
6.  Deploy the Bicep configuration: az deployment sub create --location <location> --template-file main.bicep Replace `<location>` with the desired Azure region for the deployment.
7.  After the deployment is complete, you can start using the Azure OpenAI model with the configured content filter and blocklist.
