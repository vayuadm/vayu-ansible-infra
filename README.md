# Vayu Infra - Ansible

[![CircleCI](https://circleci.com/gh/vayuadm/vayu-ansible-infra.svg?style=svg)](https://circleci.com/gh/vayuadm/vayu-ansible-infra)

You can find here Ansible playbooks for Infrastructure purposes.

---
## Prerequisites - Install Ansible

Run these command (Tested on Ubuntu 16):

```shell
> sudo apt-add-repository -y ppa:ansible/ansible
> sudo apt-get update
> sudo apt-get install -y ansible
```
---
## Ansible - Provisioning
This playbook installs all the packages & dependecies required for running kops on the local machine.
<BR />
**Please note that `sudo` permissions are required to run this playbook**

Clone this repo & run this command in the terminal:
```shell
~/retina-ansible-kops$ sudo ansible-playbook provision.yaml
```
You can also supply the `--tags` parameter when running the command to specify what to provision.
Available tags:
* apt - provision only apt-packages
* wget - provision only wget-packages
* pip - provision only pip-packages
* sys_update - update all apt system packages

usage: 
```shell
~/retina-ansible-kops$ sudo ansible-playbook provision.yaml --tags "apt,pip"
```
---
## Ansible - AWS/kops infrastructure management for k8s
This playbook will create/destroy an AWS cluster infrastructure & deploy k8n on nodes
<BR />
**Please note that your aws credentials must resign in `~/.aws/credentials`, the file structure is as such:**
``` aws
[default]
aws_access_key_id = AWS_ACCESS_KEY
aws_secret_access_key = AWS_ACCESS_SECRET
```

**Also note that this playbook creates the environment in AWS according to the configuration file in the project directory under `./vars/main.yaml`**

### Available commands ###
#### `ansible-playbook aws.yaml --tags "aws-create"` ####
Creates the following infrastructure in aws:
* Route53 Zone - Registers a DNS name
* Route53 Zone's register - Adds a sub-DNS to the new zone
* S3 Bucket - Creates a bucket for storing k8s cluster configurations
* EC2 Key-pair - Create & adds a key-pair to the EC2 Region provided in the configurations file

#### `ansible-playbook aws.yaml --tags "kops-create"` ####
Creates the actual k8s infrastructure in aws using kops, will add the some of the following & others:
* EC2 instances (for master & nodes)
* EC2 security groups
* EC2 volumes
* EC2 key-pair
* Route53 zone registers
* IAM user for k8s

#### `ansible-playbook aws.yaml --tags "create"` ####
Creates both aws & kops infrastructure

#### `ansible-playbook aws.yaml --tags "aws-destroy"` ####
Removes all aws related infrastructure
#### `ansible-playbook aws.yaml --tags "kops-destroy"` ####
Removes all kops related infrastructure
#### `ansible-playbook aws.yaml --tags "destroy"` ####
Removes all infrastructure

---
#### Running Ansible playbooks as CircleCI build using CircleCI API ####
``` bash 
curl -X POST https://circleci.com/api/v1.1/project/github/vayuadm/vayu-ansible-infra?circle-token=$TOKEN -data "{"build_parameters":{"ANSIBLE_ACTION": $ACTION}}"
```
ACTION: 
* create  - creates Vayu cluster on AWS
* destroy - remove Vayu cluster from AWS
* empty   - runs project's test playbook
    
TOKEN: CircleCI secret
