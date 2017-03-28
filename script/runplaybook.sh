#!/bin/sh
# available actions: create, destroy, kops-create, kops-destroy, aws-create, aws-destroy, deployment

runPlaybook() {
    if [ -z "$2" ]
    then
      echo Running ansible test playbook
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client test.yaml
    elif [ "$2" == *"create"*]
    then
      echo Running aws-create.yaml playbook action: "$2"
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client aws-create.yaml --tags "$2"
    else
      echo Running aws-destroy.yaml playbook action: "$2"
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client aws-destroy.yaml --tags "$2"
    fi
}

runPlaybook $1 $2
