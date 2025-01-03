#!/bin/bash

# Checks all running process for given user and allows for sorting of memory or CPU

sort_choice=""

echo "Printing processes running for current user $USER:"

while [ "$sort_choice" != "memory" ] && [ "$sort_choice" != "cpu" ]; do
    echo "Would you like to sort processes by memory or cpu?"
    read sort_choice
done

if [ "$sort_choice" == "memory" ]; then
    ps -aux --sort=-%mem | grep "$USER"
else
    ps -aux --sort=-%cpu | grep "$USER"
fi 
