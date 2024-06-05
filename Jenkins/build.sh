#!/bin/bash

# Create the project directory
mkdir -p jenkins-flask-app
cd jenkins-flask-app

# Create app.py
cat <<EOF > app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Create requirements.txt
cat <<EOF > requirements.txt
Flask==2.1.1
EOF

# Create Dockerfile
cat <<EOF > Dockerfile
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install the Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set the entry point to the Flask application
CMD ["python", "app.py"]
EOF

echo "Project files have been created successfully."

# Optional: Build the Docker image
# Uncomment the lines below if you want to build and run the Docker image immediately
# docker build -t jenkins-flask-app .
# docker run -d -p 5000:5000 --name flask-app jenkins-flask-app
