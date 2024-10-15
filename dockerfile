FROM ubuntu:latest

# Create a non-root user
RUN useradd -m actions-runner

WORKDIR /home/actions-runner

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    sudo \
    jq \
    libicu-dev \
    git \
    gnupg

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Download and extract the GitHub Actions runner
RUN curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz && \
    echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | sha256sum -c && \
    tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz && \
    rm actions-runner-linux-x64-2.320.0.tar.gz

# Add a script to configure and start the runner
COPY . .
RUN chmod +x start.sh && \
    chown -R actions-runner:actions-runner /home/actions-runner

# Switch to the non-root user
USER actions-runner

# Set the entrypoint to the start script
ENTRYPOINT ["./start.sh"]
