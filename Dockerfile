FROM ubuntu:16.04

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && mkdir node1 && apt-get update && apt-get install -y git wget make build-essential libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev
COPY go1.9.2.linux-amd64.tar.gz .
RUN tar zxvf go1.9.2.linux-amd64.tar.gz -C /usr/local \
&& rm go1.9.2.linux-amd64.tar.gz \
&& echo GOROOT=/usr/local/go > $HOME/.bashrc \
&& mkdir -p Go/bin && mkdir -p Go/pkg && mkdir -p Go/src \
&& echo GOPATH=$HOME/Go >> $HOME/.bashrc \
&& echo PATH=$GOROOT/bin:/usr/local/go/bin:$PATH >> $HOME/.bashrc \
&& . $HOME/.bashrc \
&& git clone --recursive --progress https://github.com/jpmorganchase/quorum.git \
&& cd quorum \
&& make \
&& cp build/bin/* /usr/bin \
&& cd .. \
&& wget https://github.com/jpmorganchase/constellation/releases/download/v0.2.0/constellation-0.2.0-ubuntu1604.tar.xz -O constellation.tar.xz \
&& tar xJf constellation.tar.xz \
&& cp constellation-0.2.0-ubuntu1604/* /usr/bin 