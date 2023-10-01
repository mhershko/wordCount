# pull official base image
FROM python:3.8.1-slim-buster

# set work directory
RUN mkdir -p /app
WORKDIR /app

# install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# copy project
COPY entrypoint.sh /app/
RUN chmod u+x /app/entrypoint.sh

COPY . /app/

EXPOSE 5000

# run entrypoint.sh
CMD ["/bin/bash", "/app/entrypoint.sh"]