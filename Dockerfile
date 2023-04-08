FROM ubuntu:18.04

# Insert Steam prompt answers
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

# Update apt repository and install SteamCMD
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
    # update registry
    && apt-get update -y \
    # install dependencies
    && apt-get install -y --no-install-recommends ca-certificates locales steamcmd curl \
    # Create symlink for executable
    && ln -s /usr/games/steamcmd /usr/bin/steamcmd \
    # Update SteamCMD and verify latest version
    && steamcmd +quit \
    # install envtemplate
    && curl -sfLo /usr/local/bin/envtemplate https://github.com/orls/envtemplate/releases/download/0.0.3/envtemplate \
    && chmod +x /usr/local/bin/envtemplate \
    # Add unicode support
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US:en'

COPY server.cfg /tmp/server.cfg
COPY entrypoint.sh /usr/bin/entrypoint.sh

# set defaults
ENV UPDATE_SERVER=false \
    NECESSE_GAME_DIR=/game \
    NECESSE_GAME_PORT=14159 \
    NECESSE_WORLD=world1 \
    NECESSE_SLOTS=10 \
    NECESSE_MOTD="Necesse Dedicated Server" \
    NECESSE_PAUSE_WHEN_EMPTY=true \
    NECESSE_GIVE_CLIENTS_POWER=true \
    NECESSE_LOGGING=true \
    NECESSE_OWNER= \
    NECESSE_LANGUAGE=en \
    NECESSE_PASSWORD= \
    NECESSE_ZIP_SAVES=true \
    NECESSE_MAX_CLIENT_LATENCY_SECONDS=30

VOLUME ["/game"]

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
