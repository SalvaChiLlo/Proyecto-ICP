#!/bin/bash

FRONTEND_STACK_NAME=frontend-proyecto-icp-$ID
FRONTEND_TEMPLATE_FILE=frontend.json
BACKEND_STACK_NAME=backend-proyecto-icp-$ID
BACKEND_TEMPLATE_FILE=backend.json

case $1 in

  "create")
    echo Create Template
    echo aws cloudformation create-stack --stack-name $FRONTEND_STACK_NAME \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation create-stack --stack-name $FRONTEND_STACK_NAME \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    echo aws cloudformation create-stack --stack-name $BACKEND_STACK_NAME \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation create-stack --stack-name $BACKEND_STACK_NAME \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --tags Key=user,Value=alucloud$ID \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "describe")
    echo Describe Template
    echo aws cloudformation describe-stacks --stack-name $FRONTEND_STACK_NAME
    aws cloudformation describe-stacks --stack-name $FRONTEND_STACK_NAME

    echo aws cloudformation describe-stacks --stack-name $BACKEND_STACK_NAME
    aws cloudformation describe-stacks --stack-name $BACKEND_STACK_NAME
  ;;

  "estimate")
    echo Estimate Cost of the Template
    echo aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    echo aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation estimate-template-cost \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "update")
    echo Update Template
    echo aws cloudformation update-stack --stack-name $FRONTEND_STACK_NAME  \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation update-stack --stack-name $FRONTEND_STACK_NAME  \
    --template-body file://`pwd`/$FRONTEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    echo aws cloudformation update-stack --stack-name $BACKEND_STACK_NAME  \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID

    aws cloudformation update-stack --stack-name $BACKEND_STACK_NAME  \
    --template-body file://`pwd`/$BACKEND_TEMPLATE_FILE \
    --parameters \
    ParameterKey=KeyPairName,ParameterValue=alucloud$ID-keypair \
    ParameterKey=UserID,ParameterValue=$ID
  ;;

  "delete")
    echo Delete Template
    echo aws cloudformation delete-stack --stack-name $FRONTEND_STACK_NAME
    aws cloudformation delete-stack --stack-name $FRONTEND_STACK_NAME

    echo aws cloudformation delete-stack --stack-name $BACKEND_STACK_NAME
    aws cloudformation delete-stack --stack-name $BACKEND_STACK_NAME
  ;;

  *)
    echo "La funcón no existe"
    ;;
esac