FROM yamamuteki/ubuntu-lucid-i386
MAINTAINER JD Hernandez


#################
# Base Setup    #
#################

# Set the locale
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Install base system software
RUN apt-get update && apt-get --yes --no-install-recommends install \
        sudo iproute curl && apt-get clean

# Install SSH Server
RUN apt-get update && apt-get --yes --no-install-recommends install \
        openssh-server && \
    apt-get clean && \
    mkdir -p /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    sed -i 's/AcceptEnv/# AcceptEnv/' /etc/ssh/sshd_config


#################
# User Setup    #
#################

# Create and configure user
RUN echo "Creating ie0521 user" && \
    useradd --create-home -s /bin/bash ie0521 && \
    mkdir -p /home/ie0521/.ssh && \
    \
    echo "Changing ie0521 user password" && \
    echo -n 'ie0521:ie0521' | chpasswd && \
    \
    echo "Enable passwordless sudo for the ie0521 user" && \
    echo 'ie0521 ALL=NOPASSWD: ALL' > /etc/sudoers.d/ie0521 && \
    chmod 0440 /etc/sudoers.d/ie0521 && \
    \
    echo "Configuring ssh keys" && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== Vagrant insecure public key" > /home/ie0521/.ssh/authorized_keys && \
    chown -R ie0521: /home/ie0521/.ssh && \
    echo "Setting correct permissions to the workspace" && \
    mkdir -p /home/ie0521/ws && chown -R ie0521: /home/ie0521/ws


########################
# Development tools    #
########################

RUN apt-get update && apt-get --yes --no-install-recommends install \
        vim nano tree ack-grep bash-completion less \
        build-essential cmake pkg-config libtool automake \
        libmpfr-dev bison texinfo zlib1g-dev \
        flex libmpc-dev

RUN apt-get update && apt-get --yes --no-install-recommends install \
        libncurses-dev libmpfr1ldbl libgmp3-dev libzip-dev verilog
########################
# Libraries            #
########################

#RUN apt-get update && apt-get --yes --no-install-recommends install \
#        python3-dev libjson-perl \
#        babeltrace \
#        libbabeltrace-ctf-dev libbabeltrace-ctf1 \
#        libbabeltrace-dev libbabeltrace1 \
#        libpopt-dev \
#        libsystemd-dev \
#        libapr1 libapr1-dev libaprutil1-dev \
#        libyaml-dev \
#        libsnappy-dev \
#        python3-lxml && \
#    apt-get clean && rm -rf /var/lib/apt/lists/*

# Launch SSH daemon
EXPOSE 22
CMD /usr/sbin/sshd -D -o UseDNS=no
