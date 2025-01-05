#!/bin/bash

# Install NodeJS and NPM and print out which versions were installed
sudo apt update
sudo apt install nodejs npm -y
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

# Download artifact file
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz
cd package

# Set environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret


# Install dependancies listed in the package.json file 
npm install

# Start the Node application
nohup node server.js &
