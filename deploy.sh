#!/usr/bin/env bash

if [ -z ${DOCKER_ID_USER} ]; then
	echo "You must set DOCKER_ID_USER"
	exit 1
fi
base_name="${DOCKER_ID_USER}/kafka-manager"

cd kafka-manager
git pull
./sbt -batch clean dist
cp target/universal/kafka-manager-*.zip ..
cd ..
ver="$(ls | grep kafka-manager-*.zip | cut -d '-' -f 3)"
echo "VER: ${ver}"
tag="$(basename $ver .zip)"
echo "TAG: ${tag}"
unzip -f "kafka-manager-${tag}.zip"
docker build --tag "${base_name}:${tag}" .
docker tag "${base_name}:${tag}" "${base_name}:latest" 
docker push "${base_name}:${tag}"
docker push "${base_name}:latest"
