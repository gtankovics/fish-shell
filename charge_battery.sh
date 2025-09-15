#!/bin/bash

# set -ex

HOMEY_IP="192.168.0.150"
HOMEY_PORT="8441"

# get battery percentage
BATTERY_PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d % -f1)

# get plug state
MAC_PLUG_STATE=$(curl --location --silent "http://$HOMEY_IP:$HOMEY_PORT/lab/macplug" | /opt/homebrew/bin/jq '.data.state')

if [ $BATTERY_PERCENTAGE -lt 20 ]; then
    if [ "$MAC_PLUG_STATE" == "false" ]; then
        curl --location -X POST "http://$HOMEY_IP:$HOMEY_PORT/lab/macplug"
    fi
elif [ $BATTERY_PERCENTAGE -gt 80 ]; then
    if [ "$MAC_PLUG_STATE" = "true" ]; then
        curl --location -X POST "http://$HOMEY_IP:$HOMEY_PORT/lab/macplug"
    fi
fi