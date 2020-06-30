
ready-dev:
	python3 -m venv .venv
	python3 -m venv django_test/.venv
	. django_test/.venv/bin/activate && pip install -r django_test/requirements
	. .venv/bin/activate && pip install -r requirements
	ln -s `readlink -f localdev/git/hooks/pre-commit` .git/hooks/pre-commit


# Docker tasks
docker-build-image:
	docker build ./ --tag=django-test:1.0

docker-run:
	docker run -p 8000:8000 django-test:1.0

docker-tag-remote:
	docker tag django-test:${APP_VERSION} ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/django-test:${APP_VERSION}

docker-login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com

docker-push-image:
	docker push ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/django-test:${APP_VERSION}


# AWS provisioning tasks
cloudformation-lint:
	yamllint cloudformation/*
	cfn-lint -t cloudformation/*

cloudformation-create-change-set:
	aws cloudformation create-change-set \
		--template-body=file://${AWS_CLOUDFORMATION_TEMPLATE} \
		--stack-name ${STACK_NAME} \
		--change-set-type ${CHANGESET_TYPE} \
		--change-set-name "${STACK_NAME}-$(git log|head -n1|cut -d" " -f2)" \
		--capabilities CAPABILITY_IAM \
		--region ${AWS_REGION}

cloudformation-execute-change-set:
	aws cloudformation execute-change-set \
		--stack-name ${STACK_NAME} \
		--change-set-name "${STACK_NAME}-$(git log|head -n1|cut -d" " -f2)" \
		--region ${AWS_REGION}
