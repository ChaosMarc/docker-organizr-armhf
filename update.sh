#!/bin/bash

cd "${0%/*}"
git remote add upstream https://github.com/linuxserver/docker-organizr-armhf.git
git fetch upstream
git pull -X theirs upstream master
sed -i -e 's/git clone https/git clone -b v2-develop https/g' root/etc/cont-init.d/30-install
if [[ "$(head -1 README.md)" != v2-develop* ]]; then
	echo -e 'v2-develop branch fork of [lsioarmhf/organizr](https://github.com/linuxserver/docker-organizr-armhf): [keksnase/organizr-v2-armhf](https://hub.docker.com/r/keksnase/organizr-v2-armhf/)\n' | cat - README.md > temp && mv temp README.md
fi
docker build -t keksnase/organizr-v2-armhf .
docker push keksnase/organizr-v2-armhf
git commit -am "automated update"
git push origin master
