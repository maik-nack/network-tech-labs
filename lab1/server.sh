#!/bin/bash

PORT="${1:-8080}"

touch google_id.sh
echo "GOOGLE_ID=" > google_id.sh

while true
do
  trap 'break' INT
  nc -lp "$PORT" -e request_handler.sh
done

rm google_id.sh
