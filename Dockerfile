ARG UBUNTU_VERSION_ARG=20.04
FROM ubuntu:${UBUNTU_VERSION_ARG} AS ansible
LABEL maintainer="Ivan Krasnuhin <i.krasnuhin@beauit.com>"
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-pip ansible sshpass openssh-client rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pycrypto pywinrm
RUN echo 'localhost' > /etc/ansible/hosts
RUN echo "ansible --version | head -n 1 | awk -F " " '{print $2}'"
CMD ["ansible-playbook", "--version"]
