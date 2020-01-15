# base image off a lightweight python image
FROM python:3.7-alpine

# make sure python doesn't buffer output
ENV PYTHONUNBUFFERED 1

# copy local requirements.txt to the container
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
# for minimal footprint
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
# install requirements using pip
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

# make a dir called app in container
RUN mkdir /app
# make /app the working (default) dir for the container
WORKDIR /app
# copy local app dir to container's app dir
COPY ./app /app

# create a user to run app from
RUN adduser -D user
# switch to user
USER user