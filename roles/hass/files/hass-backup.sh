#!/bin/bash

# Backup homeassistant to Freenas

cmd="/usr/local/bin/nst"
token=$TELEGRAM_TOKEN
telegram_group=$TELEGRAM_GROUP
msg_title="HASS Backup to FreeNas"
msg_body="Backup"
hass_config_path=$HASS_CONFIG_PATH
hass_user=$HASS_USER
nas=$NAS_HOST
nas_backup_path=$NAS_BACKUP_PATH

eval `ssh-agent`
ssh-add $HASS_PRIVKEY_PATH

$cmd --recipient $telegram_group -t $token "$msg_title" "$msg_body started at $(date)"
log=$(rsync -av \
--exclude={'deps','home-assistant.log','.vscode','.vscode','.gitignore','.git','.cloud','.circleci','.uuid','secrets.yaml'} \
$HASS_CONFIG_PATH \
$HASS_USER@$NAS_HOST:$NAS_BACKUP_PATH)

$cmd --recipient $telegram_group -t $token "$msg_title" "$msg_body Finished at $(date) \n $log"
