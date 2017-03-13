#!/bin/sh
# available actions: create, destroy, kops-create, kops-destroy, aws-create, aws-destroy

runPlaybook() {
    if [ -z "$2" ]
    then
      echo Running ansible test playbook
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client test.yaml
    else
      echo Running ansible playbook action: "$2"
      docker run -it -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client aws.yaml --tags "$2"
    fi

    if [ -z "$1" ]
    then
      echo Publishing results to Slack
      docker run -it -e SLACK_TOKEN="$1" -v $PWD:/ansible/playbooks -v ~/.aws:/root/.aws vayuadm/vayu-ansible-client slack-publish.yaml
    fi
}

runPlaybook $1 $2
