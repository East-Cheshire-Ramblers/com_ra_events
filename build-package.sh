#!/usr/bin/env bash
set -euo pipefail

component="com_ra_events"
manifest="ra_events.xml"
version="$(sed -n 's:.*<version>\(.*\)</version>.*:\1:p' "$manifest" | head -1)"
package="${component}-${version}.zip"

rm -rf dist
mkdir -p dist

zip -r "dist/${package}" "$manifest" admin forms src tmpl \
	-x '.DS_Store' \
	-x '*/.DS_Store' \
	-x '*.old' \
	-x '*.old2'

echo "Created dist/${package}"
