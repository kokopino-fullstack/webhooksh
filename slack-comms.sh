#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$DIR"/secrets

WEBHOOK=$SLACK_CHANNEL_WEBHOOK
TITLE=$1
MSG=$2

usage () {
    echo "Usage: $0 title message" >&2
    exit 1
}

[ -n "$*" ] || usage

if [ -z "$WEBHOOK" ]
then
    echo "Error: SLACK_CHANNEL_WEBHOOK is not defined - add it to secrets file"
	exit 1
fi
PROXY=""
if [ ! -z "$PROXY" ]
then
    PROXY="--proxy $PROXY"
    echo "Using proxy: $PROXY"
  exit 1
fi


curl -X POST "$WEBHOOK" \
$PROXY \
-H 'Content-type: application/json' \
-d @- << EOF
{
	"blocks": [
		{
			"type": "header",
			"text": {
				"type": "plain_text",
				"text": "$TITLE"
			}
		},
		{
			"type": "section",
			"text": {
				"type": "mrkdwn",
				"text": "$MSG"
			}
		}
	]
}
EOF
