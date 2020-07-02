FROM postgres:11.5

RUN apt-get update \
  && apt-get install -y \
  ssmtp \
  openssh-client\
  sshpass
COPY dumpDatabase.sh .
COPY ssmtp.config .

ENTRYPOINT [ "/bin/sh" ]
CMD [ "./dumpDatabase.sh" ]
