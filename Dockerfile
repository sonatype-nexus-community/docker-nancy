FROM golang:latest AS builder
LABEL author="DJ Schleen"
LABEL version="0.1"
LABEL maintainer="sonatype-nexus-community"

RUN git clone https://github.com/sonatype-nexus-community/nancy
WORKDIR nancy
RUN CGO_ENABLED=0 GOOS=linux go build -o nancy .

FROM alpine:latest
LABEL author="DJ Schleen"
LABEL version="0.1"
LABEL maintainer="sonatype-nexus-community"

RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/* 

COPY --from=builder /go/nancy/nancy /nancy
ENV PATH "$PATH:/tmp"
WORKDIR /tmp
ENTRYPOINT [ "/nancy" ]