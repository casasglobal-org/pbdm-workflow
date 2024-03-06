AWS_ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`
ECR="dev-pbdm-wf-worker-image"
export AWS_REGION="eu-west-1"
export AWS_ACCESS_KEY_ID=AKIAZUTGR2QLQBHUAZHR
export AWS_SECRET_ACCESS_KEY=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

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

sudo docker build --no-cache  --provenance=false --platform=linux/amd64 -t pbdm-worker .
sudo docker tag pbdm-worker ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR}:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR}:latest
