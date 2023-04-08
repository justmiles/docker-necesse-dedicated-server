#!/bin/bash

# if the game isn't installed, set to install
if [ ! -f "$NECESSE_GAME_DIR/Server.jar" ]; then
  echo "No installation found. Installing..."
  UPDATE_SERVER=true
fi

# honor UPDATE_SERVER, which could be set outside of this script as well as above to force updates
if [ "$UPDATE_SERVER" == "true" ]; then
  set -ex
  mkdir -p $NECESSE_GAME_DIR
  steamcmd +force_install_dir $NECESSE_GAME_DIR +login anonymous +app_update 1169370 validate +quit
  set +ex
fi

# set config 
mkdir -p $NECESSE_GAME_DIR/cfg
envtemplate < /tmp/server.cfg > $NECESSE_GAME_DIR/cfg/server.cfg

# start the server
cd $NECESSE_GAME_DIR

./jre/bin/java -jar Server.jar -nogui -localdir -world ${NECESSE_WORLD} -owner "${NECESSE_OWNER}"
