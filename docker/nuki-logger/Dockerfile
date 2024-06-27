FROM bitnami/minideb

ARG NUKI_LOGGER_VERSION

RUN apt update
RUN apt install -y ca-certificates && update-ca-certificates
COPY tmp/nuki-logger-${NUKI_LOGGER_VERSION} /nuki-logger
RUN  chmod +x /nuki-logger

ENTRYPOINT ["/nuki-logger"]
