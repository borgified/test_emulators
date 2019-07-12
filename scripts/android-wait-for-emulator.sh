#!/bin/bash

# Originally written by Ralf Kistner <ralf@embarkmobile.com>, but placed in the public domain

set +e

bootanim=""
failcounter=0
#timeout_in_sec=360 # 6 minutes
timeout_in_sec=900

until [[ "$bootanim" =~ "stopped" ]]; do
  bootanim=`adb -e shell getprop init.svc.bootanim 2>&1 &`
#echo bootanim=\`$bootanim\`
  if [[ "$bootanim" =~ "device not found" || "$bootanim" =~ "device offline"
    || "$bootanim" =~ "running" || "$bootanim" =~  "error: no emulators found" ]]; then
    let "failcounter += 1"
    if [[ $failcounter -gt timeout_in_sec ]]; then
      exit 1
    fi
  fi
  sleep 1
done
echo "$failcounter"
