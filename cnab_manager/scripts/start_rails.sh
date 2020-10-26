#!/usr/bin/env bash

# Remove any possible PID
echo "Removing PID file"
rm -f /application/tmp/pids/server.pid 

# Start the server
rails s -b 0.0.0.0