#!/usr/bin/bash

for FILESYSTEM in $(mount | grep -E 'ext|xfs|jfs|btrfs|mmfs' | awk '{print $3}')
do
  echo "### Filesystem $FILESYSTEM"
  IFS="$(printf '\nx')" && IFS="${IFS%x}"
  for i in $(find $FILESYSTEM -xdev -type f -perm -o+r  ! -user root ! -name  \*.go ! -name \*.c ! -name \*.h ! -name \*.js ! -name *.py ! -name metadata.json ! -name \*.html )
  do 
    file $i | grep "ASCII text"  > /dev/null
    if [ $? -eq 0 ]
    then
      cat $i | tr '[ <>,:\[\]\9\0]' '\n' | grep -P '\b(?=.\d)(?=.*[a-z])(?=.*[-\#\$\.\%\&\*])\b.{8}' > /dev/null
      if [ $? -eq 0 ] 
      then 
        UNAME=$(stat --format '%U' "$i")
        echo "Possible password(s) found in $i owned by $UNAME"
      fi
    fi
  done
done
