#!/bin/bash

source google_id.sh

read http_type path _
z=read
while [ ${#z} -gt 2 ]
do
  read z
done

resp_h="HTTP/1.1"
if [ $http_type == "GET" ]
then
  if [ -z $GOOGLE_ID ]
  then
    echo -e "$resp_h 404 Not Found\n\nID of table wasn't found\n"
  else
    response=$(curl -s -w "\n%{http_code}" "https://docs.google.com/spreadsheets/d/$GOOGLE_ID/gviz/tq?tqx=out:csv")
    resp=($response)
    code=${resp[-1]}
    if [ $code == "200" ]
    then
      body=${response:0:${#response}-3}
      echo -e "$resp_h 200 OK\r\ncontent-type: text/csv; charset=utf-8\r\ncontent-disposition: attachment; filename='data.csv'; filename*=UTF-8''data.csv\r\n"
      echo "$body"
    else
      echo -e "$resp_h 400 Bad Request\n\nUnknown error with code $code\n"
    fi
  fi
elif [ $http_type == "PUT" ]
then
  echo -e "$resp_h 200 OK\r\n"
  IFS='/' read -ra tmp <<< $path
  GOOGLE_ID=${tmp[1]}
  echo "$GOOGLE_ID"
  echo "GOOGLE_ID=$GOOGLE_ID" > google_id.sh
else
  echo -e "$resp_h 405 Method Not Allowed\n\n405\n"
fi
