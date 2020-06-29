
ready-dev:
	python3 -m venv django_test/.venv
	. django_test/.venv/bin/activate && pip install -r django_test/requirements
	ln -s `readlink -f localdev/git/hooks/pre-commit` .git/hooks/pre-commit

docker-build-image:
	docker build ./

docker-login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com

docker-push-image:
	docker tag django-test:${APP_VERSION} ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/django-test:${APP_VERSION}
	docker push ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/django-test:${APP_VERSION}

fargate-update-service:
	#TODO

