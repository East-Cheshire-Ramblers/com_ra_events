#!/usr/bin/env bash
set -euo pipefail

component="com_ra_events"
manifest="ra_events.xml"
version="$(sed -n 's:.*<version>\(.*\)</version>.*:\1:p' "$manifest" | head -1)"
package="${component}-${version}.zip"
module="mod_ra_events"
module_manifest="modules/${module}/${module}.xml"
module_version="$(sed -n 's:.*<version>\(.*\)</version>.*:\1:p' "$module_manifest" | head -1)"
module_package="${module}-${module_version}.zip"

rm -rf dist
mkdir -p dist

zip -r "dist/${package}" "$manifest" admin forms src tmpl \
	-x '.DS_Store' \
	-x '*/.DS_Store' \
	-x '._*' \
	-x '*/._*' \
	-x '*.old' \
	-x '*.old2'

echo "Created dist/${package}"

(
	cd "modules/${module}"
	zip -r "../../dist/${module_package}" "${module}.xml" index.html "${module}.php" tmpl \
		-x '.DS_Store' \
		-x '*/.DS_Store' \
		-x '._*' \
		-x '*/._*' \
		-x '*.old' \
		-x '*.old2'
)

echo "Created dist/${module_package}"
