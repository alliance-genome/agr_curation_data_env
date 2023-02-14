all:
	docker build --pull --no-cache --build-arg REG=100225593120.dkr.ecr.us-east-1.amazonaws.com --build-arg DOCKER_PULL_TAG=stage --build-arg ALLIANCE_RELEASE=5.4.0 -t 100225593120.dkr.ecr.us-east-1.amazonaws.com/agr_curation_data_env:stage -f ./Dockerfile .
