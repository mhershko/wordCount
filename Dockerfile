# pull official base image
FROM --platform=linux/amd64 python:3.8.1-slim-buster

# set work directory
RUN mkdir -p /app
WORKDIR /app

# install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY . /app/

EXPOSE ${APP_PORT}

ENTRYPOINT ["python"]
CMD ["src/main.py"]
