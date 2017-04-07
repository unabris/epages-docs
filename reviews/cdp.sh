#!/bin/bash

if [ "$#" -ne 2 ] ;then
    cat <<EOF
Usage
    ./cdp.sh <DATE> <TIME>
Examples
  ./cdp.sh 20170328 1300
EOF
    exit 1
fi

if [[ "$(uname)" == "Darwin" ]]; then
  SINCE=$(echo $(date -u -j -f "%Y%m%d %H%M" "$1 $2" +%s)000)
else
  SINCE=$(date --utc -d "$1 $2" +%s)
fi

http --verify no --body https://cdp.epages.works/job/cdp/api/json tree==allBuilds[timestamp,result,description] | \
jq --arg since $SINCE '.allBuilds | map(select(.timestamp >= ($since | tonumber))) | map(select(.result | tostring | contains("SUCCESS"))) | map({repo: .description | split(" ") | (.[0])}) | group_by(.repo) | map( {"repo": .[0].repo, "deployments":length } ) | sort_by(-.deployments, .repo)' | \
jq -r '.[] | [.repo, .deployments] | @csv' | \
awk -v FS="," 'BEGIN{print "<table class=\"cdp\">"; print "  <thead>"; print"    <tr><th>repo</th><th>deployments</th></tr>"; print "  </thead>"; print "  <tbody>"} {gsub ("\"",""); printf "    <tr><td>%s</td><td>%s</td></tr>%s",$1,$2,ORS} END{print "  </tbody>"; print "</table>"}'
