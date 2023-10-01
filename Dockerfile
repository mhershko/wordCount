FROM python:latest

WORKDIR /app

# Copy requirements.txt first for better cache on later pushes
COPY requirements.txt /app/requirements.txt

# pip install python deps from requirements.txt on the resin.io build server
RUN pip install -r requirements.txt

# This will copy all files in our root to the working  directory in the container
COPY . /app

ENTRYPOINT [ "python" ]

CMD ["controller.py" ]