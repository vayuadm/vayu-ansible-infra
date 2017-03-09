#!/bin/sh

readonly TAG_DESTROY="destroy"

runPlaybook() {
    echo running ansible playbook action: $1
    if [ "$1" = "${TAG_DESTROY}" ]
    then
        docker run -it --rm -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client aws.yaml --tags "${TAG_DESTROY}"
    else
        docker run -it --rm -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client test.yaml
    fi
}

runPlaybook $1