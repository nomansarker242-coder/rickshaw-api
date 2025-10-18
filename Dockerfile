FROM alpine:latest

ARG PB_VERSION=0.30.4

RUN apk add --no-cache unzip ca-certificates

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ \
    && chmod +x /pb/pocketbase

WORKDIR /pb

EXPOSE 8090

CMD ["./pocketbase", "admin", "reset", "--email", "admin@example.com", "--password", "123456"]


