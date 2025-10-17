# Use a lightweight base image
FROM alpine:latest

# Define the PocketBase version as an argument
ARG PB_VERSION=0.30.4

# Install necessary tools
RUN apk add --no-cache unzip ca-certificates

# Download and unzip PocketBase binary
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/
RUN chmod +x /pb/pocketbase


# Copy initial data (optional, for persistence)
COPY ./pocketbase_0.30.4_windows_amd64/pb_data /pb/pb_data

# Expose the port PocketBase uses
EXPOSE 8090


# Command to run PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]

