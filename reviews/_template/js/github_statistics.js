// Command for obtaining the GitHub statistics of the last 2 weeks
// git log --shortstat --no-merges --since "2 weeks ago" | grep "files changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print files, "files changed,", inserted, "insertions(+),", deleted, "deletions(-)"}'

var gitHub = {
  "repos": ["krypton", "epages-devportal", "epages-docs", "beyond-private_sdk", "krypton-provisioning",
  "beyond-private_sdk", "shippo-app"],
  "files": [282, 92, 189, 63, 180, 0, 0],
  "additions": [3594, 1367, 189, 1096, 5693, 0, 0],
  "deletions": [-1476, -699, -147, -132, -264, -0, -0]
}

checkElement('#chart') //use whichever selector you want
  .then((element) => generateGitHubStatistic(element));
