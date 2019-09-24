FROM ubuntu:18.04

RUN echo "===> Adding Ansible's PPA..."  && \
    apt-get update  &&  apt-get install -y gnupg2    && \
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | tee /etc/apt/sources.list.d/ansible.list           && \
    echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | tee -a /etc/apt/sources.list.d/ansible.list    && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7BB9C367    && \
    DEBIAN_FRONTEND=noninteractive  apt-get update  && \
    \
    \
    echo "===> Installing Ansible..."  && \
    apt-get install -y ansible  && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apt-get install -y python-pip              && \
    pip install --upgrade pycrypto pywinrm     && \
    apt-get install -y sshpass openssh-client  && \
    \
    \
    echo "===> Removing Ansible PPA..."  && \
    rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d/ansible.list  && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    echo 'localhost' > /etc/ansible/hosts && \
    echo "ansible --version | head -n 1 | awk -F " " '{print $2}'"

CMD [ "ansible-playbook", "--version" ]