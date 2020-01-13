#!/bin/bash

# Generates a link including all changed services from the supplied date onward for easy docs pasta.

function usage() {
  echo "Usage:"
  echo "  $0 2017-07-04"
}

[ -z "$1" ] && usage && exit 1

BASEURL="http://localhost:3274/delta?from=${1}&hide=title&hide=resource-link&nameFilter=%20origin%2Fmaster&suppress=skipped_tests&suppress=class_complexity&suppress=test_execution_time"

SERVICES=$(cat << EOF
ng-api-proxy
ng-auth
ng-checkout
ng-config-server
ng-gradle-plugins
ng-intercom-connector
ng-merchant-ui
ng-pdf-rendering
ng-product-management
ng-product-view
ng-provisioning
ng-shared
ng-shop
ng-signup
ng-site
ng-storage-proxy
ng-tax
ng-order
ng-unity-connector
ng-mail-gateway
ng-mail-rendering
ng-google-shopping
EOF
)

function hasChanged() {
  curl -s "${BASEURL}&key=com.epages.ng:${1}:origin/master" \
    | sed -n 's/.*(\(\(+\|-\).*\)).*/\1/pg' \
    | tr -dc '[0-9\n]' \
    | grep '[^0]' &>/dev/null
}

url="${BASEURL}"
for service in $SERVICES ;do
  if hasChanged "$service" ;then
    url="${url}&key=com.epages.ng:${service}:origin/master"
  fi
done

echo "$url"
