#!/bin/bash

# Check all processes running for given user
echo "The processes running for user $USER:"
ps aux | grep "$USER"
