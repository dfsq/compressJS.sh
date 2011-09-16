#!/bin/sh

API_URL=http://closure-compiler.appspot.com/compile
COMPILATION_LEVEL=SIMPLE_OPTIMIZATIONS
DATEFORMAT=`date +"%d%m%y"`;
NEWFILE="build${DATEFORMAT}.js";

# Itearate through all files
for f in $*
do
	code="${code} --data-urlencode js_code@${f}"
done

`curl \
--url ${API_URL} \
--header 'Content-type: application/x-www-form-urlencoded' \
${code} \
--data output_format=text \
--data output_info=compiled_code \
--data compilation_level=${COMPILATION_LEVEL} \
--output ${NEWFILE}`