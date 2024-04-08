#!/bin/bash

command -v ansible-playbook >/dev/null 2>&1 || { echo "Для скрипта требуется установленный ansible: sudo apt install ansible"; exit 1; }

if [ ! $# == 3 ]; then echo "Использование: $0 HOSTNAME USER PASSWORD"; exit; fi

if [ -f ".env" ]; then source .env; fi

HOSTNAME=$1
USER=$2
PASSWORD=$3
INVENTORY="$(mktemp).yaml"

export ANSIBLE_HOST_KEY_CHECKING=False

echo "install:
  hosts:
    ${HOSTNAME}:
  vars:
    ansible_user: root
    admin_user_name: ${USER}
    admin_user_password: ${PASSWORD}
" > $INVENTORY
ansible-playbook -i $INVENTORY install.yaml --ask-pass

rm -f $INVENTORY
