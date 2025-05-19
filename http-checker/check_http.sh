#!/bin/bash

status_codes=(100 200 302 404 500)

make_request() {
    local code=$1
    local url="https://httpstat.us/$code"

    response=$(curl -s -w "\n%{http_code}" "$url")
    body=$(echo "$response" | sed '$d')
    status=$(echo "$response" | tail -n1)

    if [[ $status =~ ^1[0-9]{2}$ || $status =~ ^2[0-9]{2}$ || $status =~ ^3[0-9]{2}$ ]]; then
        echo "[INFO] Status: $status"
        echo "[INFO] Body: $body"
        echo "--------------------------"
    elif [[ $status =~ ^4[0-9]{2}$ || $status =~ ^5[0-9]{2}$ ]]; then
        echo "[ERROR] Status: $status"
        echo "[ERROR] Body: $body"
        echo "[EXCEPTION] HTTP error occurred with status code $status"
        echo "--------------------------"
    else
        echo "[WARNING] Unknown status code: $status"
        echo "--------------------------"
    fi
}

for code in "${status_codes[@]}"; do
    make_request "$code"
done
