FROM ubuntu
RUN apt-get update && apt-get install -y gnupg2 sudo

VOLUME /home

RUN groupadd crypto

ADD setup.sh /opt/
ADD start.sh /
ENTRYPOINT ["/start.sh"]
CMD ["/bin/bash"]
