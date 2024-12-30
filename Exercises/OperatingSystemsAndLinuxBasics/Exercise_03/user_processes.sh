#!/bin/bash

# Check all processes running for given user
if [ -z "$1" ]; then
    ps -aux
else
    ps -aux | grep $1
fi
