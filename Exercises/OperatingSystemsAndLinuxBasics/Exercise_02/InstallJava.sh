#!/bin/bash

is_java_installed() {
    if command -v java &> /dev/null; then
        return 1
    else
        return 0
    fi
}

get_java_version() {
    java_version=$(java -version 2>&1 | awk -F[\"_] 'NR==1{print $2}')
    echo $java_version
}

is_version_11_or_greater() {
    version_11="11"
    if [ "$(printf '%s\n' "$1" "$version_11" | sort -V | head -n1)" = "$version_11" ]; then
        echo "version $1 is greater than or equal to $version_11"
        return 1
    else
        echo "version $1 is less than $version_11"
        return 0
    fi    
}

install_java() {
    echo "Installing Java..."
    sudo apt update
    sudo apt install default-jdk -y
    
    # Verify installation
    is_java_installed
    if [ $? -eq 1 ]; then
        echo "Java was installed"
        java_version=$(get_java_version)
        is_version_11_or_greater $java_version    
        if [ $? -eq 1 ]; then
            echo "Java installation was successful"
            return 1
        else
            echo "Java installation was not successful"
            return 0
        fi
    else
        echo "Java installation failed"
        return 0
    fi 
}


# Check if Java is installed
install_java
