#!/bin/bash

# it very simple... but it checks if the service is running or not
if systemctl is-active tech-talk &> /dev/null; then
  echo "Service is running"
else
  echo "Service is not running"
  exit 1
fi

# Wait 3 seconds for the service to start (sometimes it takes a while)
sleep 3

# Check HTTP response
if curl -sSf http://localhost/ &> /dev/null; then
  echo "HTTP response is successful"
  exit 0
else
  echo "Failed to get HTTP response"
  exit 1
fi