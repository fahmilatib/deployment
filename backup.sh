#!/bin/sh

DEPLOYMENT_ID=foobar
BASE_BACKUP_DIR=/root/backup
BACKUP_DIR=$BASE_BACKUP_DIR/$DEPLOYMENT_ID

if [ -f $BACKUP_DIR.tar.gz ]; then
    echo
    echo "Backup has been performed earlier"
    exit 1
fi

if [ ! -d $BASE_BACKUP_DIR ]; then
    mkdir $BASE_BACKUP_DIR
fi

mkdir $BACKUP_DIR

echo
echo 'Backing up...'
echo

cp --preserve=mode,ownership --parents -v /root/app/contact.php $BACKUP_DIR
cp --preserve=mode,ownership --parents -v /root/app/index.php $BACKUP_DIR

echo
echo 'Zipping...'
echo

tar -C $BASE_BACKUP_DIR -czvf $BACKUP_DIR.tar.gz $DEPLOYMENT_ID

# clean up

rm -rf $BACKUP_DIR

echo
echo 'Done'
echo "$BACKUP_DIR.tar.gz"
exit 0
