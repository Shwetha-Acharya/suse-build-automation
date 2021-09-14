#!/bin/bash

if [[ $# -lt 3 ]] ; then
    echo 'please add flavor of suse followed by series and version of glusterfs as arguments. Example:bash clone-gluster-suse.sh leap15  8 8.5'
    
    exit 0
fi

flavor=$1
series=$2
version=$3

echo "Cloning the glusterfs-suse repo"
git clone https://github.com/gluster/glusterfs-suse.git

cd glusterfs-suse

git checkout -b ${flavor}-${version} origin/${flavor}-glusterfs-${series}

sed -i '/Version:/c\Version:        '$version'%{?prereltag}' glusterfs.spec

sed '/^\%changelog/r'<(
    echo "* `date +"%a %b %d %Y"` glusterpackager at redhat.com"
    echo "- GlusterFS ${version} GA"
) -i -- glusterfs.spec

git add glusterfs.spec
echo "contents of glusterfs-suse:"
ls -l
git commit  -m "GlusterFS ${version} GA (${flavor})"
cd ..

echo "Please check if the build is successful at https://build.opensuse.org/project/subprojects/home:glusterfs."
echo "If the build is successful trigger push-changes.sh"
echo "If the build is unsuccessful, make the necessary changes at specfiles and add patches if required both at OBS and local repo. Confirm that the build is successful and then trigger push-changes.sh"
