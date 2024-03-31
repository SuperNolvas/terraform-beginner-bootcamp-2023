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

#### Shebang

The shebang line tells the operating system which program to use to understand and execute the script's commands. For Bash scripts, the most common shebang is `#!/bin/bash`. In this project `#!/usr/bin/env bash` is used 

- for portability for different OS distributions 
- Searches the users PATH for BASH executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Considerations

When executing the BASH script we can use the `./` shorthand notation to execute the BASH script

eg `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

```sh
eg `source ./bin/install_terraform_cli`
```

#### Linux Permissions considerations

To make our BASH scripts executable we need to change Linux permission for the fix to be executable at the user mode

chmod u=x ./bin/install_terraform_cli

https://en.wikipedia.org/wiki/Chmod
https://www.gitpod.io/docs/configure/workspaces

