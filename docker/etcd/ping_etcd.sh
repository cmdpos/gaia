#!/usr/bin/env bash


function ping() {

    echo "======================="
    echo "ping $1..."

    docker exec ${1} /bin/sh -c "/usr/local/bin/etcd --version"
    docker exec ${1} /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl version"
    docker exec ${1} /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl endpoint health"
    docker exec ${1} /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl put foo bar"
    docker exec ${1} /bin/sh -c "ETCDCTL_API=3 /usr/local/bin/etcdctl get foo"

}

ping $1
