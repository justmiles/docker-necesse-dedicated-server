## Docker - Necesse Dedicated Server

Docker image for Necesse dedicated server

[![Build Status](https://drone.justmiles.io/api/badges/justmiles/docker-necesse-dedicated-server/status.svg)](https://drone.justmiles.io/justmiles/docker-necesse-dedicated-server)

## Environment Variables

| Environment Var                      | Default Value              | Description                                                                        |
| ------------------------------------ | -------------------------- | ---------------------------------------------------------------------------------- |
| `UPDATE_SERVER`                      | `false`                    | Force a steam update of the game on startup                                        |
| `NECESSE_GAME_DIR`                   | `/game`                    | Location of game saves                                                             |
| `NECESSE_GAME_PORT`                  | `14159`                    | Server default port                                                                |
| `NECESSE_WORLD`                      | `world1`                   | Name of world                                                                      |
| `NECESSE_SLOTS`                      | `10`                       | Number of player slots                                                             |
| `NECESSE_MOTD`                       | `Necesse Dedicated Server` | Message of the day                                                                 |
| `NECESSE_PAUSE_WHEN_EMPTY`           | `true`                     | Whether or not to pause when connections are empty                                 |
| `NECESSE_GIVE_CLIENTS_POWER`         | `true`                     | If true, clients will have much more power over what hits them, their position etc |
| `NECESSE_LOGGING`                    | `true`                     | If true, will create log files for each server start                               |
| `NECESSE_OWNER`                      | ``                         | Limit owner permission to this player. If left blank all players are owners        |
| `NECESSE_LANGUAGE`                   | `en`                       | Limit owner permission to this player. If left blank all players are owners        |
| `NECESSE_PASSWORD`                   | ``                         | Password protect server. Leave blank for no password                               |
| `NECESSE_ZIP_SAVES`                  | `true`                     | If true, will create new saves uncompressed                                        |
| `NECESSE_MAX_CLIENT_LATENCY_SECONDS` | `30`                       |                                                                                    |

## Volumes

- `/game` location of game server files and saves

## Examples

Docker run:

```bash
docker run --rm \
  --name necesse-dedicated-server \
  -p 14159:14159/udp \
  -v $PWD/game:/game \
  justmiles/necesse-dedicated-server:latest
```

Docker-Compose:

```yaml
version: "3.7"
services:
  necesse-dedicated-server:
    container_name: necesse-dedicated-server
    image: justmiles/necesse-dedicated-server:latest
    restart: always
    ports:
      - 14159:14159/udp
    volumes:
      - ./game:/game
```

## Useful Links

- [Necesse documentation](https://necessewiki.com/Multiplayer-Linux)
