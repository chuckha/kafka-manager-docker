#!/usr/bin/env bash

if [ -z ${DOCKER_ID_USER} ]; then
	echo "You must set DOCKER_ID_USER"
	exit 1
fi

cd kafka-manager
./sbt -batch dist
cp target/universal/kafka-manager-*.zip ..
cd ..
ver="$(ls | grep kafka-manager-*.zip | cut -d '-' -f 3)"
echo "VER: ${ver}"
tag="$(basename $ver .zip)"
echo "TAG: ${tag}"
unzip -f "kafka-manager-${tag}.zip"
image_name="${DOCKER_ID_USER}/kafka-manager:${tag}"
docker build --tag "${image_name}" .
docker push "${image_name}"