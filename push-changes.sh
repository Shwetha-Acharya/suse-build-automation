#!/bin/bash

if [[ $# -lt 3 ]] ; then
    echo 'please add flavor of suse followed by series and version of glusterfs as arguments. Example: #bash push-changes.sh leap15 8  8.5'

    exit 0
fi

flavor=$1
series=$2
version=$3

cd glusterfs-suse
git push origin ${flavor}-${version}:${flavor}-glusterfs-${series}

cd..
#cleanup
rm -rf glusterfs-suse 
