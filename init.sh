#!/bin/sh
ATPATH=$(type -p $0)
ATPATH=${ATPATH%/*}
mkdir cross
cd cross
ln -s $ATPATH/* .
make prep
cd arch*
