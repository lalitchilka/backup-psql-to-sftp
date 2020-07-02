DUMP_FILE_NAME="backupPostgres`date +%Y-%m-%d-%H-%M`.gz"
echo "Creating dump: $DUMP_FILE_NAME"
chfn -f 'Dummy' root
echo "Subject:$EMAILSUBJECT \n\n $EMAILMSGSTART\n Date: `date`\n File: $DUMP_FILE_NAME\n File Path: $SFTPSTORAGEPATH \n DB_Host: $PGHOST\n SFTP_HOST: $SFTPHOST\n" | sendmail -C ssmtp.config $EMAILRECIPIENTS

pg_dumpall | gzip > $DUMP_FILE_NAME

sshpass -p $SFTPPASSWORD scp -o StrictHostKeyChecking=no $DUMP_FILE_NAME $SFTPUSER@$SFTPHOST:$SFTPSTORAGEPATH

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Subject:$EMAILSUBJECT \n\n $EMAILMSGFAIL\n" | sendmail -C ssmtp.config $EMAILRECIPIENTS
  echo "Back up not created, check db connection settings"
  exit 1
fi

echo "Subject:$EMAILSUBJECT \n\n $EMAILMSGSUCCESS\n Date: `date`\n File: $DUMP_FILE_NAME\n File Path: $SFTPSTORAGEPATH \n DB_Host: $PGHOST\n SFTP_HOST: $SFTPHOST\n" | sendmail -C ssmtp.config $EMAILRECIPIENTS
echo 'Successfully Backed Up'
exit 0