#!/bin/bash

APP_NAME="server.js"
APP_PATH="./package/$app_name"

# Outputs the applications PID and port number
get_port_num() {
    local pid=$(pgrep -f "$APP_NAME")
    port=$(sudo netstat -tulnp | grep "$pid" | awk "/$pid\/node/ {print $4}" | cut -d':' -f4)
    echo "App $APP_NAME is running with PID $pid and is running on port $port"
}

# Outputs the applications running state
is_running() {
    if ps aux | grep -v grep | grep -w "$APP_NAME" > /dev/null; then
        get_port_num
    else
        echo "App "$APP_NAME" is NOT running"
    fi
}

# Install NodeJS and NPM and print out which versions were installed
echo "Installing NodeJS and NPM..."
apt update
apt install -y nodejs npm curl net-tools
echo ""
echo "################"
echo ""

# Read user input for log directory
echo -n "Set log directory location for the application (absolute path):"
read LOG_DIRECTORY
if [ -d "$LOG_DIRECTORY" ]; then
    echo "$LOG_DIRECTORY already exists"
else
    mkdir "$LOG_DIRECTORY"
    echo "New directory $LOG_DIRECTORY has been created"
fi

# Display NodeJS & NPM version
echo "Node.js version: $(node -v) installed"
echo "npm version: $(npm -v) installed"

echo ""
echo "################"
echo ""

# Download artifact file
if [ ! -e "$APP_PATH" ]; then
    echo "Downloading artifact..."
    wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
    tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz
fi

cd package

# Set environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
export LOG_DIR="$LOG_DIRECTORY"

# Install dependancies listed in the package.json file 
npm install

# Start the Node application
node server.js &

sleep 1 

is_running
