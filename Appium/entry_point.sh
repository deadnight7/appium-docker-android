#!/bin/bash

NODE_CONFIG_JSON="/root/nodeconfig.json"
APPIUM_LOG="/var/log/appium.log"
CMD="xvfb-run appium --log $APPIUM_LOG"

function generate_node_config() {
  if [ -z "$CUSTOM_NODE_CONFIG" ]; then
    /root/generate_config.sh $NODE_CONFIG_JSON
  fi
}

if [ ! -z "$REMOTE_ADB" ]; then
  /root/wireless_connect.sh
fi

if [ ! -z "$CONNECT_TO_GRID" ]; then
  generate_node_config
  CMD+=" --nodeconfig $NODE_CONFIG_JSON"
fi

pkill -x xvfb-run

$CMD
