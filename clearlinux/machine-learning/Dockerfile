FROM clearlinux
MAINTAINER lvader@gmail.com

ARG swupd_args

RUN while swupd check-update ; do swupd update $swupd_args ; done && \
 swupd bundle-add machine-learning-basic machine-learning-web-ui editors sysadmin-basic network-basic sysadmin-hostmgmt && \
 rm -rf /var/lib/swupd

CMD 'bash'
