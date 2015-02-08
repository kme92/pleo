#!/bin/sh

PVT_OS="$(uname)"
echo $PVT_OS

if [ $# = 0 ]; then
	echo "Missing project name argument"
	exit 1
fi

if [ "$PVT_OS" = "Darwin" ]; then
	echo "Mac OS X"
	export PATH="../../macosx:$PATH"
	macprojtool.sh $1.upf rebuild

elif [ "$(uname -o)" = "Cygwin" ]; then
	echo "cygwin on Windows"
	export PATH="../../bin:$PATH"
	ugobe_project_tool $1.upf rebuild

elif [ "$PVT_OS" = "Linux" ]; then
	echo "Linux OS"
	export PATH="../../linux:$PATH"
	ugobe_project_tool $1.upf rebuild

else
	printf "Unsupported platform:"
fi
