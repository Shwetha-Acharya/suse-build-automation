# suse-build-automation
Automate build triggers at https://build.opensuse.org/repositories/home:glusterfs


# PRE REQUISITES:

1. Install zypper and osc
  ```# dnf -y install zypper```
  ```# sudo zypper in osc```

2. add your user and password details at end of ~/.config/osc/oscrc if oscrc file already exists
  ```# vim ~/.config/osc/oscrc

    user=<YOUR USER NAME in OBS>
    keyring=1
    credentials_mgr_class=osc.credentials.TransientCredentialsManager
    pass=<YOUR PASSWORD for OBS>
  ```
  
  if oscrc file does not exist, then create ~/.config/osc/oscrc and add following lines to it
  ```
    [general]
    apiurl = https://api.opensuse.org
    [https://api.opensuse.org]
    keyring=1
    user=<YOUR USER NAME in OBS>
    pass=<YOUR PASSWORD for OBS>
    credentials_mgr_class=osc.credentials.PlaintextConfigFileCredentialsManager
  ```

Or 

*you can simply use github actions in this project. Github actions will take care of all the pre-requisites and triggering of below mentioned scripts.*

# CONTENTS
# 
There are three scripts in this repo:

	a. clone-gluster-suse.sh
	b. trigger-build.sh
	c. push-changes.sh



# clone-gluster-suse.sh
```
USAGE:
# bash clone-gluster-suse.sh <suse falvor> <glusterfs series> <glusterfs version>

EXAMPLE:
# bash clone-gluster-suse.sh leap15  8 8.5

WORKING:
clones the recent glusterfs suse repo and makes the necessary changes at specfile.
```



# trigger-build.sh
```
USAGE:
# bash trigger-build.sh <suse branchname from https://build.opensuse.org/project/subprojects/home:glusterfs > <glustefs-series> <glusterfs version>

EXAMPLE:
# bash trigger-build.sh  Leap_15.1 8 8.5

WORKING:
using a tool named osc, this script takes care of triggering the build at  
https://build.opensuse.org/project/subprojects/home:glusterfs
```


# push-changes.sh
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
