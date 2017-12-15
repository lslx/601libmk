#!/bin/bash
# build libdvm.so
source ~/.bash_profile_port
echo androot: $androot
patchpath=$MAIN_DATA_ROOT/importantbk

cd $androot

__def_path
if [[ $? != 0 ]];then
    exit 1
fi
swcache

chgejava2 7
cd build/core/clang/
pached=`md5sum HOST_x86_common.mk | grep dd541e9680dd5f53622ddb3bb48ff552 | wc -l`
if [ ! "1" == $pached ];then
    patch < $patchpath/0001-Ubuntu-16.04-adaption.patch
fi
cd $androot
source build/envsetup.sh
if [ ! -e "drv_copyed" ];then
    extractanddrv n5_ham_M4B30Z_60_a23
    touch drv_copyed
fi
lunch aosp_hammerhead-userdebug
cd art/runtime
mm -j9

