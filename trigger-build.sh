#!/bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'please add flavor of suse followed by version of glusterfs as arguments. Example: #bash trigger-build.sh leap15 8.5'

    exit 0
fi

flavor=$1
version=$2

#Example: osc co home:glusterfs:SLES15SP1-5/
osc co home:glusterfs:${flavor}

mkdir home:glusterfs:${flavor}/GlusterFS-${version}

cp -r glusterfs-suse/ home:glusterfs:${flavor}/GlusterFS-${version}/
rm -rf README.md

osc addremove glusterfs-suse/ home:glusterfs:${flavor}/GlusterFS-${version}/

#push the files to OBS
cd home:glusterfs:${flavor}/GlusterFS-${version}/
osc ci * -m "update ${flavor}-GlusterFS:${version}

#trigger build
echo "Build will be automatically triggered"
echo "Incase you want to retrigger the build, use #osc rebuildpac <project> <package> [<repo> [<arch>]] or simply use User Interface at OBS
cd
