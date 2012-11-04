#!/bin/sh

# Constants
SERVICE_URL=http://closure-compiler.appspot.com/compile
NEWFILE="build-`date +"%d%m%y"`.js"

# Check if files to compile are provided
if [ $# -eq 0 ]
then
	echo 'Nothing to compile. Specify input files as command arguments. E.g.'
	echo './compressjs file1.js file2.js file3.js'
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

# Send request
curl \
--url ${SERVICE_URL} \
--header 'Content-type: application/x-www-form-urlencoded' \
${code} \
--data output_format=json \
--data output_info=compiled_code \
--data output_info=statistics \
--data output_info=errors \
--data compilation_level=SIMPLE_OPTIMIZATIONS |

# echo '{"compiledCode":"var a\u003d51,b\u003d0.4\u003cMath.random();a\u0026\u0026b\u0026\u0026alert(\"Test record\");","statistics":{"originalSize":80,"originalGzipSize":97,"compressedSize":56,"compressedGzipSize":76,"compileTime":0}}' |
# echo '{"compiledCode":"","errors":[{"type":"JSC_PARSE_ERROR","file":"Input_1","lineno":1,"charno":32,"error":"Parse error. missing ) after argument list","line":"alert('This script consists of' error);"}],"statistics":{"originalSize":121,"originalGzipSize":126,"compressedSize":0,"compressedGzipSize":20,"compileTime":0}}' |

python -c '
import json, sys 
data = json.load(sys.stdin) 
if "errors" in data:
	print "========================================\n COMPILATION FAILED WITH ERRORS \n========================================"
	for err in data["errors"]:
		print "File: %s, %d:%d" % (err["file"], err["lineno"], err["charno"])
		print "Error: %s" % err["error"]
		print "Line: %s" % err["line"]
else:
	print "========================================\n COMPILATION COMPLETED \n========================================"
	print "Original size: %db, gziped: %db" % (data["statistics"]["originalSize"], data["statistics"]["originalGzipSize"])
	print "Compressed size: %db, gziped: %db" % (data["statistics"]["compressedSize"], data["statistics"]["compressedGzipSize"])
	print "Compression rate: %.2f" % (float(data["statistics"]["compressedSize"]) / int(data["statistics"]["originalSize"]))

	filename = "'$NEWFILE'"
	f = open(filename, "w")
	f.write(data["compiledCode"])

	print "\nBuild file %s created." % filename
'

echo "\n"