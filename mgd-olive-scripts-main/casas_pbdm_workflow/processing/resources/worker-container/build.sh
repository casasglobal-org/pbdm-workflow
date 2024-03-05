AWS_ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`
ECR="dev-pbdm-wf-worker-image"
REGION="eu-west-1"

aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

docker build --no-cache  --provenance=false --platform=linux/amd64 -t pbdm-worker .
docker tag pbdm-worker ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ECR}:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ECR}:latest