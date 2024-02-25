#!/bin/bash

ROOT_FOLDER=$(dirname "$(dirname "${BASH_SOURCE[0]}")")
PARAMETER_PATH=$1
PROFILE=$2 # optional
ENV_PATH=$3 # optional

function retrieve_parameter_value() {
    if [[ -n $PROFILE ]]; then
        aws ssm get-parameters-by-path \
            --profile "$PROFILE" \
            --region eu-central-1 \
            --with-decryption \
            --path "$PARAMETER_PATH" \
            --query "Parameters[*].[Name,Value]" \
            --output text
    else
        aws ssm get-parameters-by-path \
            --region eu-central-1 \
            --with-decryption \
            --path "$PARAMETER_PATH" \
            --query "Parameters[*].[Name,Value]" \
            --output text
    fi
}

function convert_params_to_env() {
    while read -r line; do
        key=$(echo "$line" | awk '{print $1}' | awk -F'/' '{print $NF}')
        value=$(echo "$line" | awk '{print $2}')
        echo "$key=$value"
    done
}

PARAMETER_VALUE=$(retrieve_parameter_value)
ENV_VALUE=$(echo "$PARAMETER_VALUE" | convert_params_to_env)
if [[ -n $ENV_PATH ]]; then
      if [[ -f "$ENV_PATH/.env" ]]; then
          mv "$ENV_PATH/.env" "$ENV_PATH/.env.old"
      fi
      echo "$ENV_VALUE" > "$ENV_PATH/.env"
      echo "Successfully created .env file in $ENV_PATH"
else
  echo "$ENV_VALUE"
fi