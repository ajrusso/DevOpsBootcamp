#!/bin/bash

# Checks all running process for given user and allows for sorting of memory or CPU and the number of processes to print

sort_choice=""
num_processes=0

echo "Printing processes running for current user $USER:"

while [ "$sort_choice" != "memory" ] && [ "$sort_choice" != "cpu" ]; do
    echo "Would you like to sort processes by memory or cpu?"
    read sort_choice
done

while [ "$num_processes" -le 0 ]; do
    echo "How many processes would you like to display?"
    read num_processes
done

if [ "$sort_choice" == "memory" ]; then
    ps -aux --sort=-%mem | grep "$USER" | head -n "$num_processes"
else
    ps -aux --sort=-%cpu | grep "$USER" | head -n "$num_processes"
fi 
