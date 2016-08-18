echo starting test

export DEFAULT_AWS_REGION=us-west-2

zip_file=$1

lambda_name=LambdaZipTest
role_name=${lambda_name}Role
lambda_handler=lambda.handler
policy_arn=arn:aws:iam::aws:policy/AWSLambdaExecute

  echo creating role
  aws iam create-role \
  --role-name $role_name \
  --output text \
  --assume-role-policy-document '{
        "Version": "2012-10-17",
        "Statement": [
          {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
          }
        ]
       }' 

  echo getting role arn
  role_arn=$(aws iam list-roles --output text | grep $role_name | awk '{print $2}')
  echo $role_arn

  echo attaching policy
  aws iam attach-role-policy \
  --role-name $role_name \
  --policy-arn $policy_arn \
  --output text 

  sleep 10 #eventual consistency

  echo creating function
  aws lambda create-function \
  --region=$DEFAULT_AWS_REGION \
  --function-name $lambda_name \
  --zip-file fileb://$zip_file \
  --role $role_arn \
  --handler $lambda_handler \
  --runtime python2.7 \
  --output text 

  echo invoking function
  echo "--------"
  aws lambda invoke \
  --region=$DEFAULT_AWS_REGION \
  --invocation-type RequestResponse \
  --function-name $lambda_name \
  --log-type Tail \
  --payload '{}' \
  --output text \
  --query LogResult \
  /dev/null | base64 -d
  echo "--------"

  echo deleting function
  aws lambda delete-function \
  --region=$DEFAULT_AWS_REGION \
  --function-name $lambda_name \
  --output text 

  echo detaching policy
  aws iam detach-role-policy \
  --role-name $role_name \
  --policy-arn $policy_arn \
  --output text 

  echo deleting role
  aws iam delete-role \
  --role-name $role_name \
  --output text 
