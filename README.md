# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilise semantic versioning for its tagging
[semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

The Terraform CLI installation instructions have changed due to gpg keyring changes. So the original gitpod.yml bash commands didn't work until they were refactored with the latest commands from the Terraform install documentation. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built using the Ubuntu Linux Distribution
Please consider checking your Linux Distribution requirements, package manager etc

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example to check OS version 

```sh
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

Whilst fixing the Terraform CLI gpg deprecation issues, we noticed the bash script installation steps we more involved. So we decided to create a BASH script to install the Terraform CLI. 

The BASH script is located here: [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

-This will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml)) tidy.
-This will make it easier to debug and manually excecute the Terraform CLI install
-This will allow better portability for other projects that need to install the Terraform CLI

#### Shebang Considerations

The shebang line tells the operating system which program to use to understand and execute the script's commands. For Bash scripts, the most common shebang is `#!/bin/bash`. In this project `#!/usr/bin/env bash` is used 

- for portability for different OS distributions 
- Searches the users PATH for BASH executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the BASH script we can use the `./` shorthand notation to execute the BASH script

eg `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

```sh
eg `source ./bin/install_terraform_cli`
```

#### Linux Permissions considerations

To make our BASH scripts executable we need to change Linux permission for the fix to be executable at the user mode
```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace

https://www.gitpod.io/docs/configure/workspaces

### Working with env vars

#### env command

We can display all the environment variables (env vars) using the `env` command

we can filter specific env vars using `grep` e.g. `env | grep AWS_`

In the terminal we can set a custom env var using `export HELLO='world'

To unset the env var use `unset HELLO` 

We can set an env var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message
```

With a BASH script we can set env without writing export e.g.

```sh
#!/user/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo e.g. `$echo HELLO`

#### Scoping of env vars

When opening new BASH terminals in VSCode it will not be aware of env vars that you have set in another terminal windows. If you want env vars to persiste across all future BASH terminals that are open you neec to set env vars in your BASH profile e.g. `.bash_profile`

##### Persisting env vars in Gitpod

We can persist env vars into Gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO=`world`
```

All future workspaces launched will set the env vars for all BASH terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars

### AWS CLI Installation

AWS CLI is installed for this project via the BASH script
[`./bin/install_aws_cli`]`.bin/install_aws_cli`

[Getting started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command
```sh
aws sts get-caller-identity
```

If it is successful you should see a JSON payload return that looks like this:

```json
 "UserId": "AKIAIOSFODNN7EXAMPLE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"

```

We'll need to generate AWS CLI credentials from IAM User in order to use the AWS CLI. IAM User should be protected with MFA. 

## Terraform Basics

### Terraform Registry

Terraform sources are providers and modules from the Terraform regsitry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are an interface to APIs that allow creation of resources in Terraform.
- **Modules** are a way to refactor or to make large amounts of Terraform code modular, portable and shareable.

[Terraform Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

## Terraform Console

We can see a list of all the Terraform commands by typing `terraform`

#### Terraform Init 

Use `terraform init` to download the binaries for the Terraform providers that we will use in this project. 

#### Terraform Plan

`terraform plan`

This generates a changeset regarding the state of the planned infrastructure and what will be invoked/changed

We can output this plan to be passed to an apply, but often you can ignore outputting

#### Terraform Apply

`terraform apply`

This will run a plan and invoke the infastructure plan executed by Terraform. To auto approve a plan use

`terraform apply --auto-approve`

## Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be using with this project

The Terraform Lock File should be committed to your version control system (VCS) e.g. Github

`.terraform.tfstate` contains information about the current state of your infrastructure. This file **should not be committe** to your VCS. You can add wildcards for this file to .gitignore 
`*.tfstate
*.tfstate.*`

to ensure that they aren't accidentally committed to the VCS

If you lose this file, you lose the knowing the state of your infrastructure. 

`.terraform.tfstate.backup` is the previous file state

### Terraform Directory

`.terraform` directory contains binaries of Terraform providers. 

