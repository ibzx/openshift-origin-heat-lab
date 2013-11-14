#!/bin/bash

cat << EOF > /etc/yum.repos.d/openshift-origin.repo
[openshift-origin]
name=openshift-origin
baseurl="https://mirror.openshift.com/pub/openshift-origin/release/2/fedora-19/packages/x86_64/"
enabled=1
gpgcheck=0
exclude=openshift-origin-util-scl
EOF

cat << EOF > /etc/yum.repos.d/openshift-origin-deps.repo
[openshift-origin-deps]
name=openshift-origin-deps
baseurl="https://mirror.openshift.com/pub/openshift-origin/release/2/fedora-19/dependencies/x86_64/"
enabled=1
gpgcheck=0
EOF

cat << EOF > /etc/yum.repos.d/jenkins.repo
[jenkins]
name=jenkins
baseurl=http://pkg.jenkins-ci.org/redhat
enabled=1
gpgcheck=1
EOF

rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

cat << EOF > /etc/yum.repos.d/puppetlabs-products.repo
[puppetlabs-products]
name=Puppet Labs Products Fedora 19 - x86_64
baseurl=http://yum.puppetlabs.com/fedora/f19/products/x86_64
gpgkey=http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
enabled=0
gpgcheck=1
EOF

yum install -y \
    policycoreutils \
    mcollective \
    httpd \
    openssh-server \
    rhc \
    ntpdate \
    rubygem-openshift-origin-node \
    openshift-origin-node-util \
    pam_openshift \
    openshift-origin-node-proxy \
    openshift-origin-port-proxy \
    openshift-origin-msg-node-mcollective \
    git \
    make \
    cronie \
    openshift-origin-cartridge-abstract \
    openshift-origin-cartridge-10gen-mms-agent \
    openshift-origin-cartridge-cron \
    openshift-origin-cartridge-diy \
    openshift-origin-cartridge-haproxy \
    openshift-origin-cartridge-mongodb \
    openshift-origin-cartridge-mysql \
    openshift-origin-cartridge-nodejs \
    openshift-origin-cartridge-python \
    openshift-origin-cartridge-postgresql \
    openshift-origin-cartridge-ruby \
    openshift-origin-cartridge-php \
    openshift-origin-cartridge-perl \
    openshift-origin-cartridge-phpmyadmin \
    puppet \
    system-config-firewall-base \
    autogen-libopts \
    ntp \
    libogg \
    libvorbis \
    flac \
    tzdata-java \
    wget \
    libasyncns \
    gsm \
    libsndfile \
    pulseaudio-libs \
    jline \
    rhino \
    ttmkfdir \
    xorg-x11-fonts-Type1 \
    java-1.7.0-openjdk \
    openshift-origin-cartridge-jenkins-client \
    jenkins \
    jenkins-plugin-openshift \
    openshift-origin-cartridge-jenkins

sed --in-place -e s/Type=oneshot/"Type=oneshot\nTimeoutSec=0"/ /lib/systemd/system/cloud-final.service

yum install -y heat-cfntools
cfn-create-aws-symlinks --source /usr/bin

