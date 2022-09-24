FROM python:3.9-alpine3.13
LABEL maintainer = "atharvbhadange"

ENV PYTHONUNBUFFERED 1

# copy defined files into the docker image, workdir to run commands from this directory inside docker and expose for port number
COPY ./requirements.txt /tmp/requirements.txt 
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# set up virtual environment 
# install pip in venv
# install the requirements.txt file
# remove tmp directory to avoid overhead
# add user with certain privleges, not recommended to use root user
RUN python -m venv /py && \ 
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
    
ENV PATH="/py/bin/:$PATH" 

#should be last line, above lines are executed as root user in next line we switch user
USER django-user