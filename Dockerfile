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

# Debug: Verify the download and extraction
RUN ls -la /tmp/ && echo "Contents of /tmp"
RUN ls -la /pb/ && echo "Contents of /pb"
RUN test -f /pb/pocketbase && echo "PocketBase binary exists" || echo "PocketBase binary not found"
RUN /pb/pocketbase --version && echo "PocketBase version check passed" || echo "PocketBase version check failed"

# Copy initial data (optional, for persistence)
# Commenting out to avoid issues if the directory is missing
# COPY ./pocketbase_0.30.4_windows_amd64/pb_data /pb/pb_data

# Expose the port PocketBase uses
EXPOSE 8090

# Runtime debug: Check environment before starting
CMD sh -c "ls -la /pb && echo 'Checking pocketbase binary' && test -x /pb/pocketbase && echo 'PocketBase is executable' || echo 'PocketBase is not executable'; /pb/pocketbase serve --http=0.0.0.0:8090"