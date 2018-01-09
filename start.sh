#!/bin/bash                                                                                                                                                  
set -u
set -e

geth --datadir qdata/node1 init genesis.json

GLOBAL_ARGS="--raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --emitcheckpoints"
nohup constellation-node tm1.conf 2>> qdata/logs/constellation1.log &
sleep 2

PRIVATE_CONFIG=tm1.conf geth --datadir /node1/qdata/node1 $GLOBAL_ARGS --raftport 50401 --rpcport 22000 --port 21000 --unlock 0 --password password.txt 2>>qdata/logs/1.log
