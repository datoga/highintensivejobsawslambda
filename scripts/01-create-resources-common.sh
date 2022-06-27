echo "Create admin"
aws \
 --endpoint-url=http://localhost:4566 \
 iam create-role \
 --role-name admin-role \
 --path / \
 --assume-role-policy-document file:./admin-policy.json
echo "Make S3 bucket"
aws \
  s3 mb s3://lambda-functions \
  --endpoint-url http://localhost:4566 

echo "Common resources initialized! 🚀"
