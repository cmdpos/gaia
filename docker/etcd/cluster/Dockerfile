FROM quay.io/coreos/etcd:latest

RUN mkdir -p /root
RUN echo "#!/bin/sh" >> /root/entry.sh
RUN echo "trap \"echo TRAPed signal\" HUP INT QUIT TERM" >> /root/entry.sh
RUN echo "/usr/local/bin/etcd --name \${1} \
    --data-dir /var/etcd-data  \
    --initial-advertise-peer-urls http://\${3} \
    --listen-client-urls http://0.0.0.0:2379 \
    --advertise-client-urls http://0.0.0.0:2379 \
    --listen-peer-urls http://0.0.0.0:2380 \
    --initial-cluster \${2} \
    --initial-cluster-token tkn \
    --initial-cluster-state new" >> /root/entry.sh
RUN echo "echo \"stopping yafabric cluster\"" >> /root/entry.sh
RUN chmod 755 /root/entry.sh

ENTRYPOINT ["/root/entry.sh"]