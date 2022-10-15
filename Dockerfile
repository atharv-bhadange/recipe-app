FROM python:3.9-alpine3.13
LABEL maintainer = "atharvbhadange"

ENV PYTHONUNBUFFERED 1

# copy defined files into the docker image, workdir to run commands from this directory inside docker and expose for port number
COPY ./requirements.txt /tmp/requirements.txt 
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# set up virtual environment 
# install pip in venv
# install the requirements.txt file
# (shell script) check if DEV == true then install requirements.dev.txt
# remove tmp directory to avoid overhead
# add user with certain privleges, not recommended to use root user

# if this file is running with the docker-compose file of this project then DEV will be over ridden by true in that file else it will remain false by deafult
ARG DEV=false
RUN python -m venv /py && \ 
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \ 
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
    
ENV PATH="/py/bin/:$PATH" 

#should be last line, above lines are executed as root user in next line we switch user
USER django-user