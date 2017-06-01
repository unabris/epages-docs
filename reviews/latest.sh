#!/bin/bash

# powerpoints the latest slides
# if you provide "pdf" as the first argument, it will generate a pdf

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
[ -f "${BASH_SOURCE[0]}.settings" ] && . "${BASH_SOURCE[0]}"

POWERPOINT_PATH="$SCRIPTDIR/../powerpoint.exe"


LAST_REVIEW_PATH=$(find "$SCRIPTDIR" -type d -iname 'review-20*' | sort | tail -n1)

if [ "$1" == "pdf" ] ;then
  shift
  OUTPUT_FILE="$SCRIPTDIR/amber-$(basename "$LAST_REVIEW_PATH").pdf"
  POWERPOINT_OPTS="-o $OUTPUT_FILE"
fi

exec "$POWERPOINT_PATH" -d "$LAST_REVIEW_PATH" $POWERPOINT_OPTS $@
