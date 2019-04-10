#!/bin/sh

DEPLOYMENT_ID=foobar
BASE_BACKUP_DIR=/root/backup
BACKUP_DIR=$BASE_BACKUP_DIR/$DEPLOYMENT_ID

if [ ! -f $BACKUP_DIR.tar.gz ]; then
    echo
    echo "Nothing to rollback"
    exit 1
fi

echo
echo 'Unzipping...'
echo

tar -C $BASE_BACKUP_DIR -xvf $BACKUP_DIR.tar.gz

echo
echo 'Rolling back...'
echo

# restore old files

cp -rv --preserve=mode,ownership $BACKUP_DIR/. /

# delete newly added files

rm -f /root/app/about.php
rm -f /root/app/controllers/admin/Home.php

# delete newly added directories

rm -rf /root/app/controllers

# clean up

rm -rf $BACKUP_DIR

echo
echo 'Done'
exit 0
