#!/bin/bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
[ -f "${BASH_SOURCE[0]}.settings" ] && . "${BASH_SOURCE[0]}"

POWERPOINT_PATH="$SCRIPTDIR/../powerpoint.exe"

if [ "$#" -ne 3 ] ;then
    cat <<EOF
Usage
    ./template.sh <DATE> <SPRINT_NUMBER> <SPRINT_NAME>
Examples
    ./template.sh 20170101 01 "This is it!"
EOF
    exit 1
fi


DATE="$1"
SPRINT_NUMBER="$2"
SPRINT_TITLE="$3"

if [[ "$(uname)" == "Darwin" ]]; then
  SONARDASH_DATE=$(date -j -f %Y%m%d -v-14d "$DATE" +%Y-%m-%d)
  DATE_DIR=$(date -j -f %Y%m%d "$DATE" +%Y%m%d)
  DATE_TEMPLATE=$(date -j -f %Y%m%d "$DATE" +%d.%m.%Y)
else
  SONARDASH_DATE=$(date --date="$DATE 14 days ago" +%Y-%m-%d)
  DATE_DIR=$(date --date="$DATE" +%Y%m%d)
  DATE_TEMPLATE=$(date --date="$DATE" +%d.%m.%Y)
fi


REVIEW_DIR_BASENAME="review-${DATE_DIR}"
REVIEW_DIR="$SCRIPTDIR/$REVIEW_DIR_BASENAME"

if [ -d "$REVIEW_DIR" ];then
    echo "'$REVIEW_DIR' already exists"
    exit 1
fi

cp -r "$SCRIPTDIR/_template" "$REVIEW_DIR"

sed -i '' \
    -e "s|{{DATE}}|${DATE_TEMPLATE}|g" \
    -e "s|{{SONARDASH_DATE}}|${SONARDASH_DATE}|g" \
    -e "s|{{SPRINT_NUMBER}}|${SPRINT_NUMBER}|g" \
    -e "s|{{SPRINT_TITLE}}|${SPRINT_TITLE}|g" \
    "$REVIEW_DIR/index.html" || exit 1

echo "$POWERPOINT_PATH $REVIEW_DIR"
