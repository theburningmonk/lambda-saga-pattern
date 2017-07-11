#!/usr/bin/env bash

set -e

usage()
{
  echo ""
  echo ""
  echo "To deploy, run ./build.sh deploy <stage> <region> <aws_profile>"
  echo "To remove, run ./build.sh remove <stage> <region> <aws_profile>"
  echo ""
  echo "aws_profile: name of local AWS profile, to set one up run 'aws configure --profile profile_name'"
  echo ""
  echo "eg. ./build.sh deploy dev us-east-1 personal"
}

if [ $# -eq 0 ]; then
  usage
  exit 1
elif [ "$1" = "deploy" ] && [ $# -eq 4 ]; then
  STAGE=$2
  REGION=$3
  PROFILE=$4

  npm install

  AWS_PROFILE=$PROFILE "node_modules/.bin/sls" deploy -s $STAGE -r $REGION
elif [ "$1" = "remove" ] && [ $# -eq 4 ]; then
  STAGE=$2
  REGION=$3
  PROFILE=$4

  npm install

  AWS_PROFILE=$PROFILE "node_modules/.bin/sls" remove -s $STAGE -r $REGION
else
  usage
  exit 1
fi