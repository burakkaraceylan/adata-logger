FROM alpine:latest
LABEL   maintainer="bkaraceylan@gmail.com"
COPY	rsyslog@lists.adiscon.com-5a55e598.rsa.pub /etc/apk/keys/rsyslog@lists.adiscon.com-5a55e598.rsa.pub
RUN	echo "http://alpine.rsyslog.com/3.7/stable" >> /etc/apk/repositories \
	&& apk --no-cache update  \
	&& apk add --no-cache \
	   rsyslog \
	   openssl\
	   curl \
	   lftp
RUN	adduser -s /bin/ash -D rsyslog rsyslog \
	&& echo "rsyslog ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /var/log/adatanet

COPY build-config.sh /build-config.sh
COPY rsyslog.conf /etc/rsyslog.conf
COPY openssl.cnf /etc/ssl/openssl.cnf
COPY imza /imza
COPY simdi_imzala.sh /etc/periodic/daily
COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh /etc/periodic/daily/simdi_imzala.sh
VOLUME ["/CA", "/etc/rsyslog.conf.d"]

CMD  ["/entry.sh"]

