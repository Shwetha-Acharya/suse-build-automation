
#!/bin/bash

if [[ $# -lt 3 ]] ; then
    echo 'please add flavor of suse followed by series and version of glusterfs as arguments. Example: #bash trigger-build.sh leap15 8.5'

    exit 0
fi

flavor=$1
series=$2
version=$3

#Example: osc co home:glusterfs:SLES15SP1-5/
osc -v co home:glusterfs:${flavor}

cd glusterfs-suse
git checkout ${flavor}-${version}
cd ..

osc mkpac home:glusterfs:${flavor}/GlusterFS-${version}
cd home:glusterfs:${flavor}/GlusterFS-${version}
osc up

cp -r ../../glusterfs-suse/* .

echo "wget https://download.gluster.org/pub/gluster/glusterfs/${series}/${version}/glusterfs-${version}.tar.gz"
wget https://download.gluster.org/pub/gluster/glusterfs/${series}/${version}/glusterfs-${version}.tar.gz

echo "contents of home:glusterfs:${flavor}/GlusterFS-${version}:"
ls -la 

echo "adding or removing changed files" 
osc -v addremove

echo "commit changes to OBS"
osc -v ci -m "update ${flavor}-GlusterFS:${version}"

#trigger build
echo "Build will be automatically triggered"
echo "Incase you want to retrigger the build, use #osc rebuildpac <project> <package> [<repo> [<arch>]] or simply use User Interface at OBS"
