# Backup-psql-to-sftp

This is the Postgres DB backup configuration. Here you'll find Dockerfile which will create a Postgres image. This container will make use of the ssmtp configurations included in the repository while running the dumpDatabase.sh script.

## Prerequisites:
* You'll need a working instance of Postgres DB.
* An email account to send the emails from.

## Steps for making a backup using this repository
* Make sure you have all the details of Postgres DB eg: PG_HOST.
* Make sure you have all the sftp storage server details eg: SFTP_STORAGEPATH, SFTP_USER, SFTP_HOST
* You can provide these values directly in the script file or send it as variables to be dynamic. In this case, I am sending these values from the Kubernetes Cron Job as well as from the values.yaml which is present in Postgres-Backup-Kubernetes-CronJob Repository.
* Once you have the configurations ready, run the docker image, and the backup will be created.



**Note: Due to privacy policies all the values in the configuration files are dummy value**