#!/bin/bash

app_name="server.js"
app_path="./package/$app_name"

# Outputs the applications PID and port number
get_port_num() {
    local pid=$(pgrep -f "$app_name")
    port=$(sudo netstat -tulnp | grep "$pid" | awk "/$pid\/node/ {print $4}" | cut -d':' -f4)
    echo "App $app_name is running with PID $pid and is running on port $port"
}

# Outputs the applications running state
is_running() {
    if ps aux | grep -v grep | grep -w "$app_name" > /dev/null; then
        get_port_num
    else
        echo "App "$app_name" is NOT running"
    fi
}

# Install NodeJS and NPM and print out which versions were installed
echo "Installing NodeJS and NPM..."
sudo apt update
sudo apt install nodejs npm -y
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

# Download artifact file
if [ ! -e "$app_path" ]; then
    echo "Downloading artifact..."
    wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
    tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz
fi

cd package

# Set environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret


# Install dependancies listed in the package.json file 
npm install

# Start the Node application
nohup node server.js &

sleep 1 

is_running
