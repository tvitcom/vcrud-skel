#!/bin/sh

## Install golang app as systemd instanse
## Preconditions: root, remote-root, $APPNAME.service
## Alertpoints: STDERR

## USING: sh system/deploy.sh instance-1 OR: sh deploy.sh micro
APPNAME="vsite-skel"
HOSTNAME=$1
REMOTE_PORT=12222
REMOTE_USER=a
REMOTE_HOST=sirius
REMOTE_DIR="/home/a/v_staff/"$APPNAME;
APPROOT=$(pwd)

rsync -e "ssh -p $REMOTE_PORT" \
	--exclude="*.sublime-project" \
	--exclude="*.sublime-workspace" \
	--exclude="$APPNAME" \
	--exclude="*.swp"	\
	--exclude=".env*"	\
	--exclude="123*" \
	--exclude="456*" \
	--exclude=".git" \
	-PLSluvr --del --no-perms --no-t \
	$APPROOT"/" $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"/"

echo "Transfered to webserver code-files $REMOTE_HOST:$REMOTE_PORT: Ok!"

exit 100
