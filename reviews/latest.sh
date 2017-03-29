#!/bin/bash

# powerpoints the latest slides

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
[ -f "${BASH_SOURCE[0]}.settings" ] && . "${BASH_SOURCE[0]}"

POWERPOINT_PATH="$SCRIPTDIR/../powerpoint.exe"


LAST_REVIEW_PATH=$(find "$SCRIPTDIR" -type d -iname 'review-20*' | sort | tail -n1)

echo "http://localhost:8000/"
echo "http://localhost:8000/?print-pdf"

exec "$POWERPOINT_PATH" -d "$LAST_REVIEW_PATH" $@
