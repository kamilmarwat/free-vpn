# Self-Hosted Outline VPN with Terraform

This repository contains a Terraform configuration to automatically deploy and configure a self-hosted [Outline VPN](https://getoutline.org/) server on AWS Lightsail. Outline is an open-source VPN solution developed by Jigsaw (a unit within Google) designed to provide a secure way to access the internet.

## Architecture

The Terraform configuration is modularized into:

- **VPC Module**: Manages networking configuration and security
- **Server Module**: Handles the Lightsail instance and SSH key management

## Prerequisites

- An [AWS Account](https://aws.amazon.com/account/): You'll need an AWS account to create the necessary resources. If you don't have one, you can create one for free.
- [Terraform](https://developer.hashicorp.com/terraform/downloads): A tool for building, changing, and versioning infrastructure safely and efficiently.
- [AWS CLI](https://aws.amazon.com/cli/): A command-line tool for interacting with AWS services.

## Setup

Before you can deploy the VPN, you need to set up your environment.

### 1. Install Terraform

Terraform is used to manage the infrastructure for the VPN. You can download it from the official website:

- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Follow the instructions for your operating system.

### 2. Install and Configure AWS CLI

The AWS CLI allows you to interact with your AWS account from the command line.

- [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

Once installed, you need to configure it with your AWS credentials. You can find your credentials in the AWS Management Console.

- [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

The easiest way to configure your credentials is to set them as environment variables:

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
export AWS_REGION="eu-central-1" # Or your preferred region
```

Replace `YOUR_ACCESS_KEY` and `YOUR_SECRET_KEY` with your actual AWS credentials.

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/free-vpn.git
   cd free-vpn
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review and customize the configuration:
   ```
   terraform plan
   ```

4. Deploy the infrastructure:
   ```
   terraform apply
   ```

5. After deployment, the Outline server details will be shown in the output, including the server's public IP address.

## Configuration Options

You can customize the deployment by modifying the variables in `variables.tf` or by providing a `.tfvars` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `region` | AWS region for resources | `eu-central-1` |
| `ssh_cidr_blocks` | CIDR blocks for SSH access | `["0.0.0.0/0"]` |
| `blueprint_id` | Lightsail blueprint ID | `ubuntu_24_04` |
| `bundle_id` | Lightsail bundle ID | `nano_2_0` |
| `environment` | Environment tag | `production` |

## Connecting to Your VPN Server

1. Download the [Outline Manager](https://getoutline.org/get-started/) application.
2. Use the SSH key from the Terraform output to connect to your server and retrieve the Outline Manager connection details.
3. Add the connection to Outline Manager and create access keys for your devices.
4. Download the [Outline Client](https://getoutline.org/get-started/#step-3) on your devices and connect using the access keys.

## Security Considerations

- By default, SSH access is allowed from any IP (`0.0.0.0/0`). For better security, restrict SSH access to your IP address.
- Regularly update the server using `apt-get update && apt-get upgrade`.
- Review the Lightsail instance security settings periodically.

## Useful Links

- [Outline VPN Official Website](https://getoutline.org/)
- [Outline GitHub Repository](https://github.com/Jigsaw-Code/outline-server)
- [Outline Client Applications](https://getoutline.org/get-started/#step-3)
- [AWS Lightsail Documentation](https://aws.amazon.com/lightsail/getting-started/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
