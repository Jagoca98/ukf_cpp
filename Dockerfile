FROM ubuntu:24.04

# Set environment variable to noninteractive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    sudo \
    iputils-ping \
    net-tools \
    wget \
    nano \
    cmake \
    libgtest-dev \
    xdg-utils \
    software-properties-common \
    libboost-all-dev \ 
    libeigen3-dev \ 
    libpcl-dev \
    libjsoncpp-dev
    
# Create a user with the specified UID
ARG USER_ID
ARG USER_NAME
ARG GROUP_ID
ARG GROUP_NAME
ARG WORKSPACE

RUN groupadd -g ${GROUP_ID} $GROUP_NAME && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash $USER_NAME && \
    echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo

RUN mkdir /${WORKSPACE} && \
    chown -R $USER_NAME:$GROUP_NAME /${WORKSPACE}

# Switch to the new user
USER $USER_ID

# Create a new workspace inside the container
WORKDIR /$WORKSPACE

# Run nothing
CMD ["tail", "-f", "/dev/null"]
