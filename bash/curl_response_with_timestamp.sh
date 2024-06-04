#!/bin/bash
# curl_response_with_timestamp.sh
# Usage: ./curl_response_with_timestamp.sh --url "https://google.com"
# Perform a curl request and print the URL, HTTP Code, timestamp, and actual data response, run every second

# Check for correct usage
if [ "$#" -ne 2 ] || [ "$1" != "--url" ]; then
    echo "Usage: $0 --url \"<URL>\""
    exit 1
fi

url=$2

# Print header outside of the loop, so it's only done once
printf "%-60s %-20s %-20s %-20s\n" "URL" "HTTP Code" "Time" "Data Response"

# Infinite loop to run every second
while true; do
    # Perform curl request to capture the HTTP response status and actual response body
    response=$(curl -s -w "%{http_code}" $url)
    http_code=${response:(-3)}
    response_body=${response::-3}

    # Get current date and time in the format YYYY/MM/DD HH:MM:SS
    datetime=$(date +"%Y/%m/%d %H:%M:%S")

    # Limit the response body to a certain length to fit the table, if necessary
    truncated_response_body="${response_body:0:50}" # Adjust the number to your needs

    # Print results in a table format
    printf "%-60s %-20s %-20s %-20s\n" "$url" "$http_code" "$datetime" "$truncated_response_body"

    # Wait for a second before the next iteration
    sleep 1
done
