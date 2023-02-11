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
SECURITY_GROUP=sg-aa1f0fd8
USER_NAME="alucloud$ID"
PRIVATE_KEY_FILE="$HOME/alucloud$ID-priv.pem"
PUBLIC_KEY_FILE="$HOME/.ssh/id_rsa.pub"

ANSIBLE_LOCAL_INVENTORY_FILE="$HOME/.ansible_hosts_local"

FRONTEND_USER_DATA="user_data_frontend.sh"
BACKEND_USER_DATA="user_data_backend.sh"

rm -f $ANSIBLE_LOCAL_INVENTORY_FILE
echo "[local]" >> $ANSIBLE_LOCAL_INVENTORY_FILE
echo "localhost ansible_python_interpreter=/usr/bin/python3" >> $ANSIBLE_LOCAL_INVENTORY_FILE
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook self-submit-ansible-slaves.yml -i $ANSIBLE_LOCAL_INVENTORY_FILE --extra-vars "total=$TOTAL_NODES keypair=$KEYPAIR security_group=$SECURITY_GROUP user_name=$USER_NAME user_script=$FRONTEND_USER_DATA image_name=frontend-bibliotecas"
ansible-playbook self-submit-ansible-slaves.yml -i $ANSIBLE_LOCAL_INVENTORY_FILE --extra-vars "total=$TOTAL_NODES keypair=$KEYPAIR security_group=$SECURITY_GROUP user_name=$USER_NAME user_script=$BACKEND_USER_DATA image_name=backend-bibliotecas"

