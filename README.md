# Dynamic DNS with Route53 and Lambda

This repository provides a Terraform configuration to set up a Dynamic DNS (DDNS) service using AWS Route53 and AWS Lambda. The service updates DNS records dynamically based on the IP address provided in the request.

## Features

- **Dynamic DNS Updates**: Automatically update DNS records in Route53 based on incoming requests.
- **AWS Lambda**: Serverless function to handle DNS updates.
- **API Gateway**: Expose the Lambda function via a REST API.
- **IAM Roles and Policies**: Secure access to AWS resources.
- **S3 Backend**: Store Terraform state in an S3 bucket.
- **Encrypted Secrets**: Use AWS SSM and KMS to securely store and retrieve credentials.

## Prerequisites

- Terraform >= 1.0
- AWS Account with necessary permissions
- S3 bucket for storing Terraform state
- DynamoDB table for state locking

## Usage

1. **Clone the repository**:
    ```sh
    git clone https://github.com/nckslvrmn/unifi_ddns_route53.git
    cd unifi_ddns_route53
    ```

2. **Configure AWS credentials**:
   Ensure your AWS credentials are configured. You can use the AWS CLI to configure them:
    ```sh
    aws configure
    ```

3. **Initialize Terraform**:
    ```sh
    terraform init
    ```

4. **Apply the Terraform configuration**:
    ```sh
    terraform apply
    ```

5. **Outputs**:
   After applying the configuration, Terraform will output the necessary information, including the API endpoint for updating DNS records.

## Configuration

- **`main.tf`**: Main Terraform configuration file.
- **`versions.tf`**: Specifies the required Terraform version and providers.
- **`modules/dyndns`**: Contains the module for setting up the DDNS service.
- **`lambda/index.py`**: Lambda function code for handling DNS updates.

## Variables

- **`domain_data`**: Object containing domain information.
- **`domain_secrets`**: Object containing credentials for the domain.

## Outputs

- **`ddns_settings`**: Non-sensitive DDNS settings.
- **`secrets`**: Sensitive DDNS settings including username and password.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgements

- [Terraform AWS Modules](https://github.com/terraform-aws-modules)
- [AWS Lambda](https://aws.amazon.com/lambda/)
- [AWS Route53](https://aws.amazon.com/route53/)

For more information, please refer to the [official documentation](https://github.com/nckslvrmn/unifi_ddns_route53.git).

Generated using [copilot]