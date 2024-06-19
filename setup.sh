#!/bin/bash


mk_key(){
  local conf=~/gpgconf
  cat > $conf <<EOF
     %echo Generating a basic OpenPGP key
     Key-Type: DSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: $USERNAME
     Name-Comment: $USERNAME key
     Name-Email: ${USERNAME}@secure.org
     Expire-Date: 0
     Passphrase: abc
     %commit
     %echo done
EOF
    gpg --batch --generate-key $conf
    gpg --list-secret-keys
    gpg --armor --export $USERNAME > /opt/keys/${USERNAME}.gpg
}


echo "+------------------+"
echo "| $USERNAME"
echo "+------------------+"


echo "=== SECRET_KEYS"
keys=$(gpg --list-secret-keys | wc -l)
if [ "$keys" -eq "0" ]
then
    mk_key
fi

echo "=== PUB_KEYS"
gpg --list-keys

echo "=== IMPORT"
for key in /opt/keys/*
do
    gpg --import "$key"
    other=$(basename $key)
    other=${other%%.gpg}
    fpr=$(gpg --with-colons --fingerprint $other | awk -F: '$1 == "fpr" {print$10; exit}')
    gpg --export-ownertrust && echo $fpr:6: | gpg --import-ownertrust
done

exec ${@-/bin/bash}
