#!/bin/bash

KEYCLOAK_URL="http://localhost:8080"
ADMIN_USER="admin"
ADMIN_PASS="admin"

REALM=$1
USERNAME=$2
EMAIL=$3
PASSWORD=$4

if [ -z "$REALM" ] || [ -z "$USERNAME" ] || [ -z "$EMAIL" ] || [ -z "$PASSWORD" ]; then
  echo "Usage: $0 <realm> <username> <email> <password>"
  exit 1
fi

echo "Getting admin access token..."

TOKEN_RESPONSE=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$ADMIN_USER" \
  -d "password=$ADMIN_PASS" \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli')

ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

if [ "$ACCESS_TOKEN" == "null" ] || [ -z "$ACCESS_TOKEN" ]; then
  echo "Failed to get access token"
  echo "$TOKEN_RESPONSE"
  exit 1
fi

echo "Creating user '$USERNAME' in realm '$REALM'..."

CREATE_USER_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$KEYCLOAK_URL/admin/realms/$REALM/users" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d "{
    \"username\": \"$USERNAME\",
    \"email\": \"$EMAIL\",
    \"enabled\": true,
    \"credentials\": [
      {
        \"type\": \"password\",
        \"value\": \"$PASSWORD\",
        \"temporary\": false
      }
    ]
  }")

if [ "$CREATE_USER_RESPONSE" == "201" ]; then
  echo "User '$USERNAME' created successfully."
else
  echo "Failed to create user. HTTP status code: $CREATE_USER_RESPONSE"
fi
