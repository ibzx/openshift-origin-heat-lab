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
    openshift-origin-broker \
    rubygem-openshift-origin-msg-broker-mcollective \
    rubygem-openshift-origin-dns-nsupdate \
    rubygem-openshift-origin-dns-bind \
    rubygem-openshift-origin-controller \
    openshift-origin-broker-util \
    rubygem-passenger \
    mod_passenger \
    openssh \
    rubygem-openshift-origin-auth-mongo \
    rubygem-openshift-origin-remote-user \
    rubygem-openshift-origin-console \
    openshift-origin-console \
    mongodb \
    mongodb-server \
    bind \
    bind-utils \
    ntpdate \
    policycoreutils \
    mcollective \
    httpd \
    openssh-server \
    rhc \
    activemq \
    activemq-client \
    git \
    puppet \
    ruby \
    ruby-devel \
    ruby-irb \
    ruby-libs \
    tar \
    yum-plugin-priorities \
    mysql-devel \
    mongodb-devel \
    system-config-firewall-base \
    rubygem-execjs \
    rubygem-uglifier \
    rubygem-listen \
    rubygem-sass \
    rubygem-sass-rails \
    autogen-libopts \
    ntp \
    rubygem-coffee-script-source \
    rubygem-coffee-script \
    rubygem-coffee-rails \
    rubygem-idn \
    rubygem-addressable \
    rubygem-crack \
    rubygem-webmock \
    rubygem-fakefs \
    rubygem-chunky_png \
    rubygem-hpricot \
    rubygem-haml \
    rubygem-fssm \
    rubygem-compass \
    rubygem-compass-rails \
    rubygem-mongo \
    rubygem-jquery-rails \
    rubygem-openshift-origin-dns-avahi \
    rubygem-ref \
    rubygem-therubyracer


sed --in-place -e s/Type=oneshot/"Type=oneshot\nTimeoutSec=0"/ /lib/systemd/system/cloud-final.service

yum install -y heat-cfntools
cfn-create-aws-symlinks --source /usr/bin

