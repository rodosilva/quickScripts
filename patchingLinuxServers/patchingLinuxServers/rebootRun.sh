#!/bin/bash

# VARIABLES
hosts='./hosts.txt'
playbook='./rebootLinux.yaml'

read -p "Pick a Tenant: cdnlab | cdncorp | cdnprod: " tenant

if ! [[ $tenant =~ ^cdnlab$ || $tenant =~ ^cdncorp$ || $tenant =~ ^cdnprod$ ]]
then
  echo "Incorrect Tenant, please pick an option"
  exit 0
fi

ansible-playbook -K -k -i ${hosts} --limit ${tenant} ${playbook}