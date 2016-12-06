#!/usr/bin/env bash
#
# This script installs puppet 3.x or 4.x and deploy the manifest using puppet apply -e "include beng_nrpe"
#
# Usage:
# Ubuntu / Debian: wget https://raw.githubusercontent.com/relybv/dirict-beng_nrpe/master/files/bootme.sh; bash bootme.sh
#
# Red Hat / CentOS: curl https://raw.githubusercontent.com/relybv/dirict-beng_nrpe/master/files/bootme.sh -o bootme.sh; bash bootme.sh
# Options: add 3 as parameter to install 4.x release

# default major version, comment to install puppet 3.x
PUPPETMAJORVERSION=4
export DEBIAN_FRONTEND=noninteractive
### Code start ###
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if [ "$#" -gt 0 ]; then
   if [ "$1" = 3 ]; then
     PUPPETMAJOR=3
   else
     PUPPETMAJOR=4
  fi
else
  PUPPETMAJOR=$PUPPETMAJORVERSION
fi

if [ "$PUPPETMAJOR" = 3 ]; then
    MODULEDIR="/etc/puppet/modules/"
  else
    MODULEDIR="/etc/puppetlabs/code/modules/"
fi

# install dependencies
if which apt-get > /dev/null 2>&1; then
    apt-get update
  else
    echo "Using yum"
fi
if which apt-get > /dev/null 2>&1; then
 apt-get install git bundler zlib1g-dev libaugeas-ruby -y -q 
else
 yum install -y git bundler zlib-devel
fi 

# get or update repo
if [ -d /root/beng_nrpe ]; then
  echo "Update repo"
  cd /root/beng_nrpe
  git pull
else
  echo "Cloning repo"
  git clone https://github.com/relybv/dirict-beng_nrpe.git /root/beng_nrpe
  cd /root/beng_nrpe
fi

# install puppet
bash /root/beng_nrpe/files/bootstrap.sh $PUPPETMAJOR

# prepare bundle
echo "Installing gems"
/opt/puppetlabs/puppet/bin/gem install puppetlabs_spec_helper --no-rdoc --no-ri -q

# install dependencies from .fixtures
echo "Preparing modules"
/opt/puppetlabs/puppet/bin/rake spec_prep

# copy to puppet module location
if [ -d $MODULEDIR ]; then
cp -a /root/beng_nrpe/spec/fixtures/modules/* $MODULEDIR
else
mkdir $MODULEDIR
cp -a /root/beng_nrpe/spec/fixtures/modules/* $MODULEDIR
fi

echo "Run puppet apply"
/usr/local/bin/puppet apply -e "include beng_nrpe"
