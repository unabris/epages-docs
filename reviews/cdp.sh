#!/bin/bash

if [ "$#" -ne 2 ] ;then
    cat <<EOF
Usage
    ./cdp.sh <DATE> <TIME> | xmllint --format -
Examples
  ./cdp.sh 20170328 1300 | xmllint --format -
EOF
    exit 1
fi

if [[ "$(uname)" == "Darwin" ]]; then
  SINCE=$(echo $(/bin/date -u -j -f "%Y%m%d %H%M" "$1 $2" +%s)000)
else
  SINCE=$(date --utc -d "$1 $2" +%s)000
fi

# Fetch build history from CDP Jenkins.
CDP=$(http --verify no --timeout 180 --body https://cdp.epages.works/job/cdp/api/json tree==allBuilds[timestamp,result,description])

# Filter newest successful builds and transform their JSON structure by splitting off the repo name from description.
# Sort the filtered list by number of deployments, highest first, followed by repo name.
DEPLOYMENTS=$(echo $CDP | \
  jq --arg since $SINCE '
    .allBuilds
    | map( select(.timestamp >= ($since | tonumber)) )
    | map( select(.result | tostring | contains("SUCCESS")) )
    | map( select(.description != null))
    | map( { repo: .description | split(" ") | (.[0]) } )
    | group_by( .repo )
    | map( { "repo": .[0].repo, "deployments": length } )
    | sort_by( -.deployments, .repo )
  '
)

# Calculate the total number of all deployments.
export TOTAL=$(echo $DEPLOYMENTS | \
  jq '
    map( to_entries )
    | add
    | group_by( .key )
    | map( { key: .[0].key, value: map(.value) | add } )
    | from_entries
    | .deployments
  '
)

# Convert the JSON to CSV and print it as HTML table.
TABLE=$(echo $DEPLOYMENTS | \
  jq -r '.[] | [.repo, .deployments] | @csv' | \
  awk -v FS="," '
    BEGIN {
      print "<table class=\"cdp\">";
      print "<thead>";
      print "<tr><th>repo</th><th>deployments</th></tr>";
      print "</thead>";
      print "<tbody>";
    } {
      gsub ("\"","");
      printf "<tr><td>%s</td><td>%s</td></tr>%s",$1,$2,ORS;
    } END {
      print "<tr class=\"all\"><td>all</td><td>";
      print ENVIRON["TOTAL"];
      print "</td></tr>";
      print "</tbody>";
      print "</table>";
    }
  '
)
echo $TABLE
echo
