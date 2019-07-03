FROM clearlinux
MAINTAINER lvader@gmail.com

ARG swupd_args
ARG UNAME=kad
ARG UID=1000
ARG GID=1000

RUN swupd update $swupd_args && \
 swupd bundle-add sysadmin-basic vim os-clr-on-clr && \
 rm -rf /var/lib/swupd

RUN groupadd -g $GID $UNAME && \
    useradd -m -u $UID -g $GID -s /bin/bash $UNAME && \
    usermod -a -G wheelnopw $UNAME

USER $UNAME
CMD /bin/bash
