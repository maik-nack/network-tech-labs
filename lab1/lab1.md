# lab1

Simple server on bash for downloading google tables in CSV format. This server could receive two requests:

- `PUT` - request that passes the ID of the google table to the URL.
- `GET` - request for getting a CSV file by ID passed in the `PUT` request. If the ID is not set yet, it returns an error with the code 404 (Not Found).
