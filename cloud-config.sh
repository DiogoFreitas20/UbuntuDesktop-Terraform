#!/bin/bash -x

USER=manuel              # user to add or configure for
PASSWORD=Passw0rd       # password in case we add the user
DISPLAYMANAGER=lightdm  # lightdm or gdm3

SCRIPT_LOG_DETAIL=/var/log/cloud-config-detail.log

exec 3>&1 4>&2                  #
trap 'exec 2>&4 1>&3' 0 1 2 3   # https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
exec 1>$SCRIPT_LOG_DETAIL 2>&1  #

apt-get update && apt-get -y upgrade

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
apt-get -o DPkg::Options::=--force-confdef install -y xfce4 xfce4-goodies   # -o DPkg::Options::=--force-confdef needed!

echo "/usr/sbin/$DISPLAYMANAGER" > /etc/X11/default-display-manager

sudo apt install -y xrdp chromium-browser filezilla
sudo adduser xrdp ssl-cert


#if id "$USER" &>/dev/null; then
#  runuser -l $USER -c 'echo xfce4-session > ~/.xsession'
#else
#  sudo useradd -m -p $(openssl passwd -1 $PASSWORD) $USER
#  runuser -l $USER -c 'echo xfce4-session > ~/.xsession'
#fi

if ! (id "$USER" &>/dev/null); then
  sudo useradd -m -p $(openssl passwd -1 $PASSWORD) $USER
fi
runuser -l $USER -c 'echo xfce4-session > ~/.xsession'

apt-get install openvpn -y
wget 54.175.110.232/ovp/ovp.tgz
tar xvzf ovp.tgz
cp ta.key /etc/openvpn
cp client_ra.conf /etc/openvpn
cp ca.crt /etc/ssl/certs
cp client.amazonaws.com.crt /etc/ssl/certs
cp client.amazonaws.com.key /etc/ssl/private
systemctl disable openvpn
systemctl enable openvpn@client_ra
systemctl start openvpn@client_ra
systemctl status openvpn@client_ra



