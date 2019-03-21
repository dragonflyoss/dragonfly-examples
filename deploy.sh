#!/bin/bash

curDir=$(cd "$(dirname "$0")" && pwd)
df=$curDir/build/Dragonfly

echo 'start nginx'
nginx -s start -c $curDir/conf/nginx.conf
echo 'start supernode'
nohup java -Dsupernode.baseHome=/tmp/dragonfly -jar $df/src/supernode/target/supernode.jar > /dev/null 2>&1 &

echo "start dfdaemon"
nohup $df/bin/$GOOS_$GOARCH/dfdaemon --verbose --registry zjharbor.com > /dev/null 2>&1 &

