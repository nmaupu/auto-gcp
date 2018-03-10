FROM alpine

COPY tmp/kube-ingwatcher /kube-ingwatcher
RUN  chmod +x /kube-ingwatcher

ENTRYPOINT ["/kube-ingwatcher"]
