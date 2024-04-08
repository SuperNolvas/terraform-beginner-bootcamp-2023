# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure 

Our root module strucure is as follows:

```
PROJECT_ROOT/
| 
├── variables.tf      # stores the structure of input variables
├── main.tf           # primary entrypoint. For a complex module, resource creation may be split into multiple files but any nested module calls should be in the main file.
├── providers.tf      # defined required providers and their configuration
├── outputs.tf        # stores our outputs
├── terraform.tfvars  # data of variables we want to load into our Terraform project
└── README.md         # required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform we can set two types of variables:
- Environment Variables - those you would set in your BASH terminal e.g. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables when we create them in the UI to be sensitive so they are not visible in the Terraform Cloud UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flaag to set an input variable or override a variable in the the tfvars file e.g. `terraform -var user_uuid="my_user_id"`

### var-file flag

The -var-file flag in the Terraform command is used to specify a file containing input variables for Terraform configurations. When you run terraform apply or terraform plan, Terraform evaluates the configuration and requires input variables. Instead of manually specifying these variables each time, you can use a variable file to provide values for these variables.

Here's how you use it:

```sh
terraform apply -var-file="example.tfvars"
```
### terraform.tfvars

This is the default file to load terraform variables in bulk

### auto.tfvars

In Terraform, auto.tfvars is a special filename that Terraform automatically loads to automatically populate values for variables. This file is typically used to store default values for variables that are not sensitive or frequently changing.

`auto.tfvars` is handy for providing default values or local overrides for variables, especially in scenarios where you don't want to specify these values directly in your configuration files or use environment variables. However, it's essential to be cautious with auto.tfvars because it can introduce unexpected changes to your infrastructure if not managed properly.

### Order of Terraform variables

Terraform uses a specific order of precedence when determining the value of a variable. If the same variable is assigned multiple values, Terraform will use the value of highest precedence, overriding any other values. Below is the precedence order starting from the highest priority to the lowest.

- Environment variables TF_VAR_variable_name
- The terraform.tfvars file
- The terraform.tfvars.json file
- Any .auto.tfvars or .auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided.
- Variable defaults

[Terraform Variables](https://www.env0.com/blog/terraform-variables)
