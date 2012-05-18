#!/bin/sh

API_URL=http://closure-compiler.appspot.com/compile
COMPILATION_LEVEL=SIMPLE_OPTIMIZATIONS
DATEFORMAT=`date +"%d%m%y"`
NEWFILE="build${DATEFORMAT}.js"

# Check if files to compile provided
if [ $# -eq 0 ]
then
	echo 'Nothing to compile. Specify your input files as command arguments:'
	echo './compressJS.sh file1.js file2.js file3.js'
	exit
fi

# Check if curl is installed
if [ -z "$(which curl)" ]
then
	echo 'Please install curl to proceed.'
	exit
fi

# Itearate through all files
for f in $*
do
	if [ -r ${f} ]
	then
		code="${code} --data-urlencode js_code@${f}"
	else
		echo "File ${f} does not exist or is not readable. Skipped."
	fi
done

if [ -z "${code}" ]
then
	echo 'Nothing to compile.'
	exit
fi

`curl \
--url ${API_URL} \
--header 'Content-type: application/x-www-form-urlencoded' \
${code} \
--data output_format=text \
--data output_info=compiled_code \
--data compilation_level=${COMPILATION_LEVEL} \
--output ${NEWFILE}`

# Check if output file exists and its size more then 1 byte
if [ ! -r ${NEWFILE} -o "$(stat -c %s ${NEWFILE})" -le 1 ]
then
	echo 'Compilation failed. Probably your code contains of errors.'
	exit
fi

echo 'Compilation completed.'