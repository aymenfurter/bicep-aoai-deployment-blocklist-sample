> [!WARNING]
> This code base is still being developed. Currently, the deployment does not yet work.

# Azure OpenAI Deployment with Content Filter and Blocklist

This Terraform module deploys an Azure OpenAI model with a custom content filter and a blocklist.

## Prerequisites

- Azure subscription
- Terraform installed

## Usage

1. Clone the repository:
    ```
    git clone https://github.com/example/openai-deployment.git
    cd openai-deployment
    ```

2. Initialize Terraform:
    ```
    terraform init
    ```

3. Modify the `main.tf` file in the root directory with your desired configuration.

4. Add your blocklist items to the `blocklist_items.txt` file in the `modules/openai_deployment` directory, one item per line.

5. Apply the Terraform configuration:
    ```
    terraform apply
    ```

6. After the deployment is complete, you can start using the Azure OpenAI model with the configured content filter and blocklist.

#