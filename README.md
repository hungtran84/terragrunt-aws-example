# How do we deploy the infrastructure in this repo?


## Pre-requisites

1. Install [Terraform](https://www.terraform.io/) version `1.1.4` and
   [Terragrunt](https://github.com/gruntwork-io/terragrunt) version `v0.36.0` or newer
1. Configure our AWS credentials using one of the supported [authenticationmechanisms](https://www.terraform.io/docs/providers/aws/#authentication).
1. Fill in our AWS Account ID's in `{environment}/env.hcl`.


## Deploying a single module

1. `cd` into the module's folder (e.g. `cd dev/ap-southeast-1/vpc`).
1. Run `terragrunt plan` to see the changes we're about to apply.
1. If the plan looks good, run `terragrunt apply`.


## Deploying all modules in a region

1. `cd` into the region folder (e.g. `cd dev`).
1. Run `terragrunt run-all plan` to see all the changes we're about to apply.
1. If the plan looks good, run `terragrunt run-all apply`.


# How is the code in this repo organized?

The code in this repo uses the following folder hierarchy:

```
environment
 └ _global
 └ region
    └ resource
```

Where:

* **Environment**: At the top level are each of our environment that associated with a specific AWS accounts, such as `dev`, `qa`, `stg`, `prd`... etc. 

* **Region**: Within each environment, there will be one or more [AWS
  regions](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html), such as
  `us-east-1`, `eu-west-1`, and `ap-southeast-2`, where we've deployed resources and implement Dissater Recovery solution. There may also be a `_global` folder that defines resources that are available across all the environments in this AWS region, such as Route 53 A records, SNS topics, and ECR repos...

* **Resource**: Within each environment, we deploy all the resources for that environment, such as EC2 Instances, Auto Scaling Groups, ECS Clusters, Databases, Load Balancers, and so on.

# Organization level variables

In the situation where we have multiple AWS accounts or regions, we often have to pass common variables down to each of our modules. Rather than copy/pasting the same variables into each `terragrunt.hcl` file, in every region, and in every environment, we can inherit them from the `inputs` defined in the root `terragrunt.hcl` file.


# TODO:

## Develop production-graded modules for wide range of AWS services.
Upcoming:
- AWS OpenSearch
- EC2 Image Builder
- Auto Scaling Group

## Enforce IaC with terragrunt CI/CD using Github Action