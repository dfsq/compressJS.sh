# CompressJS - make single javascript file ready for production

Very simple bash script which compresses javascript files with Google Closure Compiler and then make a single file of them. Reduce file sizes and save bandwidth with just one simple command.

## Usage

Files you want to compress and add to the resulting file are separated with spaces. Run next command in terminal:

```bash
$ ./compressjs.sh jquery-ui-1.8.16.custom.min.js chat-widget.js templ.min.js
```

Sure you can use wildcards in file names:

```bash
$ ./compressjs.sh scripts/*.js
```

## Home page

[Home page].

[Home page]: http://dfsq.info/site/read/bash-google-closure-compiler
