# Container image
FROM alpine:3.10
# Install prerequisites
RUN apk add --no-cache curl ca-certificates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git
# Copies code file from action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
