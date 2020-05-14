.DEFAULT_GOAL := help
.PHONY: help 

## VARIABLES ##
BASE_PATH = app
PROJECT_NAME = aws-cdk-boilerplate
IMAGE = $(PROJECT_NAME):latest
DEPLOY_REGION ?= eu-west-1
ENV ?= dev
PROFILE ?= default

# Container
copy_requirements:
	@cp $(BASE_PATH)/requirements.txt docker/resources/requirements.txt

build.image: copy_requirements ## Build image for development: make build.image
	@docker build -f docker/Dockerfile -t $(IMAGE) ./docker
	@rm docker/resources/requirements.txt

container:
	@docker run --rm -it\
	 -v $(PWD)/$(BASE_PATH):/$(BASE_PATH) \
	 -v ~/.aws/config:/root/.aws/config \
	 -v ~/.aws/credentials:/root/.aws/credentials \
	 -w /$(BASE_PATH) \
	 -e AWS_DEFAULT_REGION=${DEPLOY_REGION} \
	 -e ENV=${ENV} \
	 $(IMAGE) \
	 $(COMMAND)

ssh: ## Connect to the container by ssh: make ssh
	@make container COMMAND=sh

# aws-cdk
init: ## application init: make init
	@make container COMMAND="cdk init --language python"

ls: ## list all stacks in the app: make ls
	@make container COMMAND="cdk ls"

synth: ## emits the synthesized CloudFormation template: make synth
	@make container COMMAND="cdk synth"

deploy: ## deploy this stack to your default AWS account/region: make deploy
	@make container COMMAND="cdk deploy --profile $(PROFILE)"

destroy: ## destroy this stack to your default AWS account/region: make destroy
	@make container COMMAND="cdk destroy -f"

diff: ## compare deployed stack with current state: make diff
	@make container COMMAND="cdk diff"

docs: ## open CDK documentation: make docs
	@make container COMMAND="cdk docs"



## HELP ##
help:
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'

