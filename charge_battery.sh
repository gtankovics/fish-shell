#!/usr/bin/env fish 

# Get Homey Token from Key chain
# https://scriptingosx.com/2021/04/get-password-from-keychain-in-shell-scripts/
set -l homeyToken (security find-generic-password -w -s 'Homey Token' -a 'homey')

# check battery percentage
if test (pmset -g batt | grep -Eo "\d+%" | cut -d % -f1) -lt 20
    # get plug state
    set -l macPlugState (curl --location --silent 'http://192.168.0.150/api/manager/devices/device/6dea7dd6-f94b-4d2d-a021-a6433c1e6461/' \
        --header 'Content-Type: application/json' \
        --header 'Authorization: Bearer '$homeyToken'' | jq '.capabilitiesObj.onoff.value')
    if not $macPlugState 
        curl --location --silent --request PUT 'http://192.168.0.150/api/manager/devices/device/6dea7dd6-f94b-4d2d-a021-a6433c1e6461/capability/onoff/' \
            --header 'Content-Type: application/json' \
            --header 'Authorization: Bearer '$homeyToken'' \
            --data '{"value": true}' >> /dev/null
    end
end
