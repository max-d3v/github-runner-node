#!/bin/bash
REPO="webservices_v2"

GITHUB_PAT="${GITHUB_PAT:-}"
GITHUB_OWNER="${GITHUB_OWNER:-}"

if [ -z "$GITHUB_PAT" ]; then
    echo "Error: GITHUB_PAT environment variable is not set."
    exit 1
fi

# Get a new runner token
RUNNER_TOKEN=$(curl -s -X POST -H "Authorization: token ${GITHUB_PAT}" \
    "https://api.github.com/repos/${GITHUB_OWNER}/${REPO}/actions/runners/registration-token" \
    | jq -r .token)

if [ -z "$RUNNER_TOKEN" ] || [ "$RUNNER_TOKEN" == "null" ]; then
    echo "Error: Failed to get runner token. Please check your GITHUB_PAT and repository name."
    exit 1
fi

# Configure the runner
./config.sh --url "https://github.com/${GITHUB_OWNER}/${REPO}" --token "${RUNNER_TOKEN}" --unattended

# Start the runner
./run.sh
