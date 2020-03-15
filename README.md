GNU Make For Heroku
===================
A simple buildpack for Heroku that calls `make`. Unlike other buildpacks for GNU Make, this one is a bit more configurable.

Features
--------
- Detection searches for [all three valid makefile names](https://www.gnu.org/software/make/manual/make.html#Makefile-Names).
- Pick a target for make with the environment variable `MAKE_TARGET`, or unset for default.

Installation
------------
If you need help with installing, these two sections may help. Remember your makefile won't be ran **until the next deployment**.

### Via Web Page
1. Copy the clone link to the repository:
	`https://github.com/Daniihh/heroku-buildpack-make.git`
2. Head over to your Heroku project's settings page
3. Under buildpacks, click add buildpack, and paste the repository link, and then click save changes

### Via Command Line
1. Ensure you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
2. Toss this into your command line:
	```sh
	heroku buildpacks:add --app=my-heroku-project https://github.com/Daniihh/heroku-buildpack-make.git
	```
	where `my-heroku-project` is the name of your Heroku project.

Configuration
-------------
If you have a specific Make target for building your project for release, you can specify it using the `MAKE_TARGET` environment variable. If you don't need to specify a Make target, you do not need to provide the `MAKE_TARGET` environment variable. Remember the new target won't be ran **until the next deployment**.

### Via Web Page
1. Head over to your Heroku project's settings page
2. Under config vars, click reveal config vars
3. In the bottom row, type in `MAKE_TARGET` for the key field, and the Make target you want ran in the value field, then click add

### Via Command Line
1. Ensure you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
2. Toss this into your command line:
	```sh
	heroku config:set --app=my-heroku-project MAKE_TARGET=build_release
	```
	where `my-heroku-project` is the name of your Heroku project, and `build_release` is the name of the Make target you want ran

Why GNU Make?
-------------
The rest of this document is dedicated to [Danii](https://danii.dev/)'s thoughts on why you should use GNU Make for your next big project.

Why GNU Make? What's so wonderful about it? GNU Make allows you to compile and rearrange output files the way you want, and doesn't waste time doing the things that have already been done. GNU Make is shell script, but for making files.

### How GNU Make Works
Makefiles is a list of targets, optional dependencies, and shell code. Each target's name corresponds with the file, or files it's shell code construct.

If a target's file is older than it's dependencies, then it is evaluated, otherwise it is ignored, as it's dependencies haven't changed.

To make a target whose name isn't associated with a file, it may be marked as "phony", that it doesn't directly create a single file, rather it makes other files via it's dependencies, or it removes files instead.

That's just some of the basics of GNU Make, but there's a whole load of documentation [here](https://www.gnu.org/software/make/manual/make.html).

### Compared To "Task Do-ers"
Make is more efficient and easier to write than Gulp, Grunt or DoIt. For one, there is no need to setup a huge runtime for the language these task do-ers use, such as Python or Node. You also don't have to `import`, `require` or `use` a module or package for file system access. With Make, you just use the builtin commands for file management like `cp`, `mv`, `mkdir` and `rm`.

Even if your project is all JavaScript or another high level language, GNU Make can still work wonders for you.

Consider the following Gulp file for a TypeScript project:
```js
const {src, dest} = require("gulp");
const ts = require("gulp-typescript");

function defaultTask() {
	const project = ts("tsconfig.json");
	return src("src/*").pipe(project).pipe(dest("out/"));
}

module.exports = {
	"default": defaultTask
}
```
On top of the already required dependencies, in order to use this you also will need to install `gulp` and `gulp-typescript`.

Now consider the same thing in a makefile:
```makefile
out: src/*
	-mkdir out/
	tsc

.PHONY: build
build: out/

.PHONY: build_and_run
build_and_run: build
	node out/index.js
```
This effectively does the exact same thing as the gulpfile, but it's a lot smaller and doesn't launch a bulky JavaScript runtime (when compared to something like bash).

Infact, the makefile actually also has the ability to build and then run immediately after.
