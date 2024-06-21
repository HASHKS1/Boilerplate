#!/bin/bash
# dns_lookup_with_timestamp.sh
# Perform nslookup and print the date time in a human-readable format, run every second

domain="google.com" # Update the hostname here

# Print header outside of the loop, so it's only done once
printf "%-30s %-30s %-30s\n" "Name" "Address" "Time"

# Infinite loop to run every second
while true; do
    # Perform nslookup
    lookup_results=$(nslookup $domain)

    # Extract Name and Address
    name=$(echo "$lookup_results" | grep 'Name:' | awk '{print $2}')
    address=$(echo "$lookup_results" | grep 'Address:' | tail -n1 | awk '{print $2}')

    # Get current date and time in the format YYYY/MM/DD HH:MM:SS
    datetime=$(date +"%Y/%m/%d %H:%M:%S")

    # Print results in a table format
    printf "%-30s %-30s %-30s\n" "$name" "$address" "$datetime"

    # Wait for a second before the next iteration
    sleep 1
done
