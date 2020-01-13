#!/bin/bash

# change dir to $1 if present
if [ -n "$1" ]; then
  if [ ! -d "$1" ]; then
    echo >&2 "\"$1\" is not a directory"
    exit 1
  fi
  cd "$1"
fi

WATCHPATH=$(pwd)
WATCHPAT='\.md'

if ! which inotifywait &>/dev/null
then
    echo "inotifywait (inotify-tools) not installed"
    exit 1
fi


inotifywait -mr --timefmt '%d-%m-%y %H:%M' --format '%T %w %f' \
-e close_write "$WATCHPATH" | while read date time dir file
do
    filepath=${dir}${file}
    relpath=$(echo "$filepath" | sed "s|$WATCHPATH/||g")

    if echo "$filepath" | grep "$WATCHPAT" &>/dev/null
    then
        echo -n "[$date $time] $relpath: "
        make --no-print-directory all | grep -v "^make\(\[[0-9]\+\]\)\?: Nothing to be done for '[[:alnum:]]\+'\.$" || echo ""
    fi
done
