# Vayu DEV-OPS

You can find here Ansible playbooks for DEV-OPS purposes.

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
~/retina-ansible-kops$ sudo ansible-playbook -s provisionLocalMachine.yaml
```

---
## Ansible - create AWS environment
This playbook will create a AWS environment for a project & deploy k8n on nodes
<BR />
**Please note that your aws credentials must resign in `/etc/boto.cfg`, the file structure is as such:**
```boto
[Credentials]
aws_access_key_id = AWS_ACCESS_KEY
aws_secret_access_key = AWS_ACESS_SECRET
```

**Also note that this playbook creates the environment in AWS according to the configuration file in `./vars/awsEnvironmentConf.yaml`**

To create the AWS environment run this command:
```shell
~/retina-ansible-kops$ sudo ansible-playbook -s createAWSenv.yaml
```


