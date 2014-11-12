# CompressJS

###  Make single javascript file ready for production

Very simple bash script which compresses javascript files with Google Closure Compiler online service and then creates a single file of them. CompressJS reduces file sizes and saves bandwidth with just one simple command.

## Usage

Files you want to compress and add to the resulting file should be separated with spaces. The last filename is a build target. 

Run next command in terminal:

```bash
$ ./compressjs.sh jquery-ui-1.8.16.custom.min.js chat-widget.js target.min.js
```

Of course you can use wildcards in file names and patterns:

```bash
$ ./compressjs.sh scripts/*.js target.min.js
```

## Home page

[Home page].

[Home page]: http://dfsq.info/site/read/bash-google-closure-compiler
