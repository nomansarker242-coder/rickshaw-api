# Use a lightweight base image
FROM alpine:latest

# Define the PocketBase version as an argument
ARG PB_VERSION=0.30.4

# Install necessary tools
RUN apk add --no-cache unzip ca-certificates

# Download and unzip PocketBase binary
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ \
    && chmod +x /pb/pocketbase

# IMPORTANT: Set working directory
WORKDIR /pb

# Expose the port
EXPOSE 8090

# Run PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
