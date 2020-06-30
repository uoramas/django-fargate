FROM python:3.8.3

# Prevent buffering of streams
ENV PYTHONUNBUFFERED 1

COPY django_test /opt/django_test/

WORKDIR /opt/django_test/

RUN pip3 install --upgrade pip
RUN pip3 install -r ./requirements
RUN ./manage.py migrate
EXPOSE 8000

CMD /usr/local/bin/gunicorn django_test.wsgi:application --bind 0.0.0.0:8000
