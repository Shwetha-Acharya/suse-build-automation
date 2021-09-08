# suse-build-automation
Automate build triggers at https://build.opensuse.org/repositories/home:glusterfs


# 1. PRE REQUISITES:

1. Install zypper and osc
  ```# dnf -y install zypper```
  ```# sudo zypper in osc```

2. add your user and password details at end of ~/.config/osc/oscrc
  ```# vim ~/.config/osc/oscrc

    user=<YOUR USER NAME in OBS>
    credentials_mgr_class=osc.credentials.TransientCredentialsManager
    pass=<YOUR PASSWORD for OBS>
  ```



# 2. CONTENTS
# 
There are three scripts in this repo:

	a. clone-gluster-suse.sh
	b. trigger-build.sh
	c. push-changes.sh



# a. clone-gluster-suse.sh
```
USAGE:
# bash clone-gluster-suse.sh <suse falvor> <glusterfs series> <glusterfs version>

EXAMPLE:
# bash clone-gluster-suse.sh leap15  8 8.5

WORKING:
clones the recent glusterfs suse repo and makes the necessary changes at specfile.
```



# b. trigger-build.sh
```
USAGE:
# bash trigger-build.sh <suse flavor> <glusterfs version>

EXAMPLE:
# bash trigger-build.sh leap15 8.5

WORKING:
using a tool names osc, takes care of triggering the build at  
https://build.opensuse.org/project/subprojects/home:glusterfs
```


# c. push-changes.sh
```
USAGE:
# bash push-changes.sh <suse flavor> <series> <version>

EXAMPLE:
# bash push-changes.sh leap15 8 8.5 

WORKING:
This script can be triggered if the build is successful at OBS.
It pushes the recent changes to upstream repo and cleans up the
local suse repo.

NOTE:
If incase the build requires any more changes or addition of any patches to succeed, 
add the required changes to the remote suse repo and update them at OBS.

Once the build succeeds, commit the changes made at local suse repo using: # git commit -a --amend
and trigger push-changes.sh

```
