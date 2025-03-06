#!/bin/bash

apk update

echo "**** installing ffmpeg ****"
apk add --no-cache ffmpeg

echo "**** installing php82-pdlib (dependency for facerecognition app) ****"
# https://github.com/linuxserver/docker-nextcloud/issues/171
apk del php82-pdlib
apk add --no-cache --upgrade -X http://dl-cdn.alpinelinux.org/alpine/edge/testing php82-pdlib
echo 'extension=/usr/lib/php82/modules/pdlib.so' > /etc/php82/conf.d/pdlib.ini

# echo "**** installing pecl ****"
# apk add --no-cache pecl


echo "**** installing bzip (dependency for facerecognition app) ****"
apk add --no-cache bzip2-dev

echo "*** enable face recognition model***"
occ app:enable facerecognition
occ face:setup -M 2G
occ face:setup -m 1
occ face:setup -m 3
occ face:setup -m 4