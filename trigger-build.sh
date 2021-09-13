#!/bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'please add flavor of suse followed by version of glusterfs as arguments. Example: #bash trigger-build.sh leap15 8.5'

    exit 0
fi

flavor=$1
version=$2

#Example: osc co home:glusterfs:SLES15SP1-5/
osc co home:glusterfs:${flavor}

cd home:glusterfs:${flavor} 
mkdir GlusterFS-${version}
cd GlusterFS-${version}

cp ../../glusterfs-suse/ .
rm -rf README.md

osc addremove

#push the files to OBS
osc ci * -m "update ${flavour}-GlusterFS:${}

#trigger build
echo "Build will be automatically triggered"
echo "Incase you want to retrigger the build, use #osc rebuildpac <project> <package> [<repo> [<arch>]] or simply use User Interface at OBS"
cd

