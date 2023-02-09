#!/bin/bash

STACK_NAME=proyecto-icp-$ID-1
TEMPLATE_FILE=template.json

case $1 in

  "create")
    echo Create Template
    echo aws cloudformation create-stack --stack-name $STACK_NAME \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation create-stack --stack-name $STACK_NAME \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "describe")
    echo Describe Template
    echo aws cloudformation describe-stacks --stack-name $STACK_NAME
    aws cloudformation describe-stacks --stack-name $STACK_NAME
  ;;

  "estimate")
    echo Estimate Cost of the Template
    echo aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "update")
    echo Update Template
    echo aws cloudformation update-stack --stack-name $STACK_NAME  \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation update-stack --stack-name $STACK_NAME  \
    --template-body file://`pwd`/$TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "delete")
    echo Delete Template
    echo aws cloudformation delete-stack --stack-name $STACK_NAME
    aws cloudformation delete-stack --stack-name $STACK_NAME
  ;;

  *)
    echo "La funcón no existe"
    ;;
esac