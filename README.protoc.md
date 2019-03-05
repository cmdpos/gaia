# Okchain 

## protoc环境配置


* 1、编译protoc

wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-all-3.6.1.tar.gz

tar xzvf protobuf-all-3.6.1.tar.gz

cd protobuf-all-3.6.1

./configure

make

make install

* 2、安装protoc-gen-go

go get -u github.com/golang/protobuf/protoc-gen-go

* 3、修改环境变量(ubuntu or centos)

vim ~/.bashrc

添加如下设置

export GOPATH=/home/kamal/go

export LD_LIBRARY_PATH=/usr/local/lib

export PATH="$PATH:$GOPATH/bin"

source ~/.bashrc

mac修改.bash_profile，添加如下配置

export GOPATH=$HOME/go

export PATH=$HOME/bin:$GOPATH/bin:$PATH

source ~/.bash_profile

* 4、回退protoc-gen-go版本

若要生成的pb文件不带XXX字段，可回退protoc-gen-go版本到7b8002

cd $GOPATH/src/github.com/golang/protobuf/

make

