# base image off a lightweight python image
FROM python:3.7-alpine

# make sure python doesn't buffer output
ENV PYTHONUNBUFFERED 1

# copy local requirements.txt to the container
COPY ./requirements.txt /requirements.txt
# install requirements using pip
RUN pip install -r requirements.txt

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