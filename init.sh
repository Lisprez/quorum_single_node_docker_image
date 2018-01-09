#!/bin/bash

rm -rf target

mkdir -p target/keys
mkdir -p target/qdata/{logs,node1}
mkdir -p target/qdata/node1/{geth,keystore}
pushd target/keys
constellation-node --generatekeys=tm1
popd
geth account new --password password.txt --keystore target/qdata/node1/keystore
cat password.txt | xargs keyfetcher target/qdata/node1/keystore/* |  sed -n '3p' | awk '{print $2}' > target/qdata/node1/geth/nodekey
PREFIX=enode://
ENODE=`cat password.txt | xargs keyfetcher target/qdata/node1/keystore/* |  sed -n '4p' | awk '{print $2}'`
IP_PORT="@127.0.0.1:21000?discport=0&raftport=50401"
STR_PREFIX=\"
STR_POSTFIX=\"
echo '[' > target/qdata/node1/static-nodes.json
echo ${STR_PREFIX}${PREFIX}${ENODE}${IP_PORT}${STR_POSTFIX} >> target/qdata/node1/static-nodes.json
echo ']' >> target/qdata/node1/static-nodes.json

cp start.sh target
cp password.txt target
cp tm1.conf target
cp genesis.json target
