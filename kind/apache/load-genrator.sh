#!/bin/bash

# Usage: ./load-generator.sh <URL> <REQUESTS_PER_SECOND> <DURATION_IN_SECONDS>
# Example: ./load-generator.sh https://example.com 10 60

URL=$1
RPS=$2
DURATION=$3

if [[ -z "$URL" || -z "$RPS" || -z "$DURATION" ]]; then
  echo "Usage: $0 <URL> <REQUESTS_PER_SECOND> <DURATION_IN_SECONDS>"
  exit 1
fi

echo "Starting load test on $URL with $RPS requests/sec for $DURATION seconds..."

end=$((SECONDS + DURATION))

while [ $SECONDS -lt $end ]; do
  for ((i = 0; i < RPS; i++)); do
    curl -s -o /dev/null "$URL" &
  done
  wait
  sleep 1
done

echo "Load test completed."
