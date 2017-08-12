#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

OUT=out.go
MAXLINES=50000
DIR=/home/userb/go/src/golang.org/x/net

(
find $DIR -name '*.go' | while read f; do
#	if [ "${f##*/}" == "tables.go" ]; then
#		continue
#	fi
	awk -F"/" '$1!="" { print $1 ;}' $f

	lines=$( wc -l $OUT | awk '{print $1}' )
	echo $f $lines >&2
	if [ $lines -gt $MAXLINES ]; then
		break
	fi
done
) > $OUT

