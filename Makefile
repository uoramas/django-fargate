
ready-dev:
	python3 -m venv django_test/.venv
	. django_test/.venv/bin/activate && pip install -r django_test/requirements
	ln -s `readlink -f localdev/git/hooks/pre-commit` .git/hooks/pre-commit

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

