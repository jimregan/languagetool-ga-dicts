#!/bin/bash
# because Debian-derivatives use dash, and that's crappy

FST_PATH="/home/jim/Playing/irishfst"

if [ x$1 != x"" ]
then
	FST_PATH=$1
fi

if [ ! -d $FST_PATH ]
then
	echo "Usage: rebuild-dicts.sh [path to irishfst]"
	echo "If you haven't already done so, run:"
	echo "  git clone https://github.com/jimregan/irishfst.git" 
	exit 1
fi

if [ x"" = x"$(which foma)" ]
then
	echo "This script requires foma to run"
	echo "On a Debian-like system, run:"
	echo "  sudo apt-get install foma-bin"
	exit 1
fi

FSTBIN_PATH="$FST_PATH/bin/all.fst"
if [ ! -e $FSTBIN_PATH ]
then
	echo "Binary transducer appears to be missing."
	echo "Did you remember to run make in the irishfst directory?"
	exit 1
fi

printf "set quit-on-fail ON \n load $FSTBIN_PATH\n pairs > pairs.tsv\n" | foma

