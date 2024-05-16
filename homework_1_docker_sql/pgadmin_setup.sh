#!/bin/sh

# Wait for pgAdmin to be ready
sleep 5

# Define the server configuration in JSON format
SERVER_JSON=$(cat <<EOF
{
    "Name": "Docker PostgreSQL",
    "Group": "Servers",
    "Host": "pgdatabase",
    "Port": 5432,
    "MaintenanceDB": "ny_taxi",
    "Username": "root",
    "Password": "root",
    "SSLMode": "prefer"
}
EOF
)

# Add the server configuration to pgAdmin
curl --silent --request POST \
    --url http://localhost:8080/api/v1/servers \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --header 'Authorization: Basic $(echo -n 'admin@admin.com:root' | base64)' \
    --data "${SERVER_JSON}"