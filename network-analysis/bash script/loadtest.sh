#!/bin/bash

# Check for required arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 <url> <number_of_agents>"
  exit 1
fi

URL=$1
NUM_AGENTS=$2

# Function definition
function perform_curl() {
  curl -s -o /dev/null "$URL"  
}
# Generate a sequence of numbers for parallelization using xargs
seq 1 $NUM_AGENTS | xargs -P 0 -I{} bash -c 'perform_curl'

