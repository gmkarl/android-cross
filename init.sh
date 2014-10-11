#!/bin/sh
ATPATH=$(type -p $0)
ATPATH=$(readlink -f $ATPATH)
ATPATH=${ATPATH%/*}
echo $ATPATH
mkdir -p cross
cd cross || exit 1
ln -s $ATPATH/* .
make prep || exit 1
cd arch*
