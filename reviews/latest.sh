#!/bin/bash

# powerpoints the latest slides
# if you provide "pdf" as the first argument, it will generate a pdf

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
[ -f "${BASH_SOURCE[0]}.settings" ] && . "${BASH_SOURCE[0]}"

echo $SCRIPTDIR


LAST_REVIEW_PATH=$(find "$SCRIPTDIR" -type d -iname '20*' | sort | tail -n1)

echo $LAST_REVIEW_PATH

cd $LAST_REVIEW_PATH

npx reveal-md index.md -w
