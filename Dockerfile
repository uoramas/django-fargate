FROM python:3.8.3

COPY django_test /opt/django_test/

WORKDIR /opt/django_test/

RUN pip3 install -r ./requirements
RUN ./manage.py migrate
EXPOSE 8000
CMD [ "./manage.py", "runserver", "0.0.0.0:8000" ]
