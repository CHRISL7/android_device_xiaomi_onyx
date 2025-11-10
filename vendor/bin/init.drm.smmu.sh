#! /vendor/bin/sh

#Copyright (c) Qualcomm Technologies, Inc.
#All Rights Reserved.
#Confidential and Proprietary - Qualcomm Technologies, Inc.

# set persist.vendor.drm.smmu property based on soc_id
# set the property
#  - 1 for Lemans(8255P/8775P)
#  - 0 for all other Automotive chipsets including Monaco(7255P)
#
# This script is launched from /device/qcom/<chipset_flavor>
# This script is triggered only from desired product_flavor ".rc" file
# thus, making sure, mobile chipsets are not impacted by this property.

if [ -f /sys/devices/soc0/soc_id ]; then
   soc_id=`cat /sys/devices/soc0/soc_id`
else
   soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

#soc_id's lemans:532(8255P)/534(8775P), monaco:606(7255P)
if [ "$soc_id" -eq 532 ] || [ "$soc_id" -eq 534 ]; then
   setprop persist.vendor.drm.smmu 1
else
   setprop persist.vendor.drm.smmu 0
fi
