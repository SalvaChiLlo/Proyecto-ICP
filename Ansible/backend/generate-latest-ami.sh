#!/bin/bash
# 
# Curso Online de Cloud Computing con Amazon Web Services 
# German Molto - @gmolto - October 2020
#
# Modificado para Proyecto-ICP por:
# 
# Salvador Chinesta Llobregat - Febrero 2023
# Ernesto Gaspar Aparicio - Febrero 2023

TOTAL_NODES=1
KEYPAIR="alucloud$ID-keypair"
SECURITY_GROUP="sg-0ba733b12c9d8f9e2"
USER_NAME="alucloud$ID"
PRIVATE_KEY_FILE="$HOME/alucloud$ID-priv.pem"
PUBLIC_KEY_FILE="$HOME/.ssh/id_rsa.pub"
BACKEND_IMAGE="ami-0116fbf96a47e1380"
BACKEND_TAG="config=backend"

ANSIBLE_LOCAL_INVENTORY_FILE="$PWD/ansible_hosts_local"

rm -f $ANSIBLE_LOCAL_INVENTORY_FILE
echo "[local]" >> $ANSIBLE_LOCAL_INVENTORY_FILE
echo "localhost ansible_python_interpreter=/usr/bin/python3" >> $ANSIBLE_LOCAL_INVENTORY_FILE
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook ./self-submit-ansible-slaves.yml -i $ANSIBLE_LOCAL_INVENTORY_FILE --extra-vars "total=$TOTAL_NODES keypair=$KEYPAIR security_group=$SECURITY_GROUP user_name=$USER_NAME image=$BACKEND_IMAGE tags=$BACKEND_TAG"
