#!/bin/bash

userfile=/etc/users
size=$(stat -c '%s' $userfile)
echo "size=$size"
if [ "$size" -gt "0" ]
then
  echo "users -> passwd"
  cat /etc/users > /etc/passwd
fi

user=${USERNAME:-zephod}
useradd -m $user
usermod -aG crypto $user

echo "passwd -> users"
cat /etc/passwd > /etc/users

chown -R root:crypto /opt/keys
chmod 775 /opt/keys
chown -R root:crypto /data
chmod 775 /data

sudo -u $user USERNAME=$user /opt/setup.sh ${@-/bin/bash}
