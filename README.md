# Bookwork Infrastructure

Terraform configuration for deploying the Bookwork application infrastructure on AWS. This setup provisions a containerized web application with API backend and frontend components using ECS Fargate, Application Load Balancer, and ECR repositories.

## Architecture Overview

This infrastructure deploys:
- **ECS Fargate Cluster**: Containerized application deployment
- **Application Load Balancer**: HTTPS traffic routing with SSL/TLS termination
- **ECR Repositories**: Container image storage for API and frontend
- **Security Groups**: Network access control
- **ACM Certificate**: SSL/TLS certificate for HTTPS

## Infrastructure Components

### Networking
- Uses the default VPC and subnets
- Application Load Balancer with public access
- Security groups for ALB and ECS tasks

### Container Services
- **API Service**: Runs on port 8080, handles `/api/*` routes
- **Frontend Service**: Runs on port 3000, serves the web application
- Both services run on ECS Fargate with 256 CPU and 512 MB memory

### Load Balancing
- HTTPS listener on port 443 with SSL certificate
- Frontend serves default traffic
- API traffic routed via `/api/*` path pattern

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 0.12 installed
- Domain name for SSL certificate (configurable via variables)

## Configuration

### Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `project` | Project name prefix for resources | `bookwork` |
| `domain_name` | Domain name for SSL certificate | `bookwork.demo.com` |
| `api_image_tag` | Docker image tag for API | `latest` |
| `frontend_image_tag` | Docker image tag for frontend | `latest` |



### Initial Setup

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

### Container Deployment

After infrastructure is provisioned:

1. Build and push your container images to the ECR repositories
2. Update the ECS services to deploy new image versions

## Outputs

After successful deployment, the following outputs are available:

- `alb_dns_name`: DNS name of the Application Load Balancer
- `api_ecr_url`: ECR repository URL for the API container
- `frontend_ecr_url`: ECR repository URL for the frontend container

## Health Checks

- **API**: Health check endpoint at `/health` (expected 200 response)
- **Frontend**: Health check at root `/` (expected 200 response)

## SSL Certificate

The infrastructure provisions an ACM certificate for the specified domain. You'll need to complete DNS validation in the AWS Console or via your DNS provider.

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

## Security Considerations

- Application Load Balancer is internet-facing
- ECS tasks run in public subnets with public IPs
- Security groups restrict access appropriately
- Consider using private subnets with NAT Gateway for production deployments

## Cost Optimization

Current configuration uses:
- ECS Fargate with minimal resource allocation (256 CPU, 512 MB memory)
- Single instance of each service

