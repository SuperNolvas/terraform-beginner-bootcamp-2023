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
