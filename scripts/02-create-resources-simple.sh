echo "Create SQS queue testQueue"
aws \
  sqs create-queue \
  --queue-name testQueue \
  --endpoint-url http://localhost:4566 

echo "Copy the simple lambda function to the S3 bucket"
aws \
  s3 cp simplelambda.zip s3://lambda-functions \
  --endpoint-url http://localhost:4566 

echo "Create the lambda simpleLambda"
aws \
  lambda create-function \
  --endpoint-url=http://localhost:4566 \
  --function-name simpleLambda \
  --role arn:aws:iam::000000000000:role/admin-role \
  --code S3Bucket=lambda-functions,S3Key=simplelambda.zip \
  --handler index.handler \
  --runtime nodejs16.x \
  --description "SQS Lambda handler for test sqs." \
  --timeout 30 \
  --memory-size 128

echo "Map the testQueue to the lambda function"
aws \
  lambda create-event-source-mapping \
  --function-name simpleLambda \
  --batch-size 1 \
  --event-source-arn "arn:aws:sqs:us-east-1:000000000000:testQueue" \
  --endpoint-url=http://localhost:4566

echo "All simple resources initialized! 🚀"

echo "Test"

aws \
  sqs send-message \
  --endpoint-url=http://localhost:4566 \
  --queue-url http://localhost:4576/000000000000/testQueue \
  --region us-east-1 \
  --message-body 'Test Message!'

