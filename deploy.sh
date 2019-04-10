#!/bin/sh

FILE_PERMISSIONS=666
DIR_PERMISSIONS=777
DEPLOYMENT_ID=foobar
BUCKET_DIR=./files
BASE_BACKUP_DIR=/root/backup
BACKUP_DIR=$BASE_BACKUP_DIR/$DEPLOYMENT_ID

if [ ! -f $BACKUP_DIR.tar.gz ]; then
    echo
    echo "Please run backup script first"
    exit 1
fi

echo
echo 'Deploying...'
echo

# files to be deleted

rm -f /root/app/contact.php

# files to be added (existing directories)

cp -v $BUCKET_DIR/about.php /root/app/about.php

# files to be added (new directories)

if [ ! -d /root/app/controllers ]; then
    mkdir /root/app/controllers
    chmod $DIR_PERMISSIONS /root/app/controllers
fi

if [ ! -d /root/app/controllers/admin ]; then
    mkdir /root/app/controllers/admin
    chmod $DIR_PERMISSIONS /root/app/controllers/admin
fi

cp -v $BUCKET_DIR/Home.php /root/app/controllers/admin/Home.php

# files to be updated

cp -v $BUCKET_DIR/index.php /root/app/index.php

echo
echo 'Updating file permissions...'

chmod $FILE_PERMISSIONS /root/app/about.php
chmod $FILE_PERMISSIONS /root/app/controllers/admin/Home.php
chmod $FILE_PERMISSIONS /root/app/index.php

echo
echo 'Done'
exit 0
