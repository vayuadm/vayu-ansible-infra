#!/bin/sh
# available actions: create, destroy, kops-create, kops-destroy, aws-create, aws-destroy

runPlaybook() {
    echo running ansible playbook action: $1
    if [ -z "$1" ]
    then
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client test.yaml
    else
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client aws.yaml --tags "$1"
    fi
    docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client slack-publish.yaml
}

runPlaybook $1
