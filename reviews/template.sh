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
  # explicitly use fully qualified path pointing to "broken" date binary on vanilla Mac OS X.
  # Alternatively use /usr/local/opt/coreutils/libexec/gnubin/date after installing it with homebrew.
  SONARDASH_DATE=$(/bin/date -j -f %Y%m%d -v-14d "$DATE" +%Y-%m-%d)
  DATE_DIR=$(/bin/date -j -f %Y%m%d "$DATE" +%Y%m%d)
  DATE_TEMPLATE=$(/bin/date -j -f %Y%m%d "$DATE" +%d.%m.%Y)
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

# TODO move to /usr/local/opt/gnu-sed/libexec/gnubin/sed
if [[ "$(uname)" == "Darwin" ]]; then
  SED="/usr/bin/sed -i ''"
else
  SED="sed -i"
fi

$SED \
    -e "s|{{DATE}}|${DATE_TEMPLATE}|g" \
    -e "s|{{SONARDASH_DATE}}|${SONARDASH_DATE}|g" \
    -e "s|{{SPRINT_NUMBER}}|${SPRINT_NUMBER}|g" \
    -e "s|{{SPRINT_TITLE}}|${SPRINT_TITLE}|g" \
    "$REVIEW_DIR/index.html" || exit 1

echo "$POWERPOINT_PATH $REVIEW_DIR"
