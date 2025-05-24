#!/bin/bash

KEYCLOAK_URL="http://localhost:8080"
ADMIN_USER="admin"
ADMIN_PASS="admin"

NEW_REALM_NAME=$1

if [ -z "$NEW_REALM_NAME" ]; then
  echo "Usage: $0 <realm-name>"
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

echo "Creating realm: $NEW_REALM_NAME..."

CREATE_REALM_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$KEYCLOAK_URL/admin/realms" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d "{
    \"realm\": \"$NEW_REALM_NAME\",
    \"enabled\": true
  }")

if [ "$CREATE_REALM_RESPONSE" == "201" ]; then
  echo "Realm '$NEW_REALM_NAME' created successfully."
else
  echo "Failed to create realm. HTTP status code: $CREATE_REALM_RESPONSE"
fi
