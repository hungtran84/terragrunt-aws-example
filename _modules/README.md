# Terraform modules
## Offical terraform modules

### IAM

- [IAM](https://github.com/terraform-aws-modules/terraform-aws-iam)

### Networking

- [VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc)

## Local modules
In order to speed up development/testing terraform resources, the local module at `_modules` is created to deploy resources to `dev` environment. Afterward, the well-crafted ones will be promote to the dedicated `terraform-modules` repo that normally a source of `stg` and `prd` environment deployment.
