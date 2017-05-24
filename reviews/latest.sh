#!/bin/bash

# powerpoints the latest slides
# if you provide "pdf" as the first argument, it will generate a pdf

function setChrome() {
  CHROME=$(which google-chome-beta google-chrome | head -n1)
   # `which` is not working?! TODO: remove after chrome 59 is out of beta
  ls -al /usr/bin/google-chrome-beta &>/dev/null && CHROME="/usr/bin/google-chrome-beta"
  [ -z "$CHROME" ] && echo "Cannot find google-chrome" && exit 1
}

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
[ -f "${BASH_SOURCE[0]}.settings" ] && . "${BASH_SOURCE[0]}"

POWERPOINT_PATH="$SCRIPTDIR/../powerpoint.exe"


LAST_REVIEW_PATH=$(find "$SCRIPTDIR" -type d -iname 'review-20*' | sort | tail -n1)

if [ "$1" == "pdf" ] ;then
  shift
  setChrome
  OUTPATH="$SCRIPTDIR/amber-$(basename "$LAST_REVIEW_PATH").pdf"
  "$POWERPOINT_PATH" -d "$LAST_REVIEW_PATH" $@ &
  PID=$!
  sleep 5
  $CHROME --headless --disable-gpu --print-to-pdf="$OUTPATH" "http://${DOCKER_IP:-localhost}:8000/?print-pdf"
  kill $PID
  docker kill reveal &>/dev/null
else
  exec "$POWERPOINT_PATH" -d "$LAST_REVIEW_PATH" $@
fi
