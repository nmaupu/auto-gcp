FROM google/cloud-sdk:alpine

RUN apk update && \
    apk add mysql-client

ENTRYPOINT ["/usr/bin/mysql"]
