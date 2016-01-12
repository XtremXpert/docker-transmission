FROM alpine:edge

MAINTAINER XtremXpert <xtremxpert@xtremxpert.com>

ENV LANG="fr_CA.UTF-8" \
	LC_ALL="fr_CA.UTF-8" \
	LANGUAGE="fr_CA.UTF-8" \
	TZ="America/Toronto" \
<<<<<<< HEAD
	TERM="xterm" \
	WHITELIST="64.228.227.3" \
=======
	TERM="xterm" \
>>>>>>> parent of 789807b... Update Dockerfile
	TRANSMISSION_HOME="/transmission/config"

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz /tmp/

RUN apk update && \
	apk update && \
	apk add \
		ca-certificates \
		mc \
		nano \
		openntpd \
		rsync \
		transmission-daemon \
		tzdata \
		unzip \
	&& \
	tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
	echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	mkdir -p /transmission/{download,watch,incomplete,config} && \
	chmod 1777 /transmission && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	rm -fr /var/lib/apk/* && \
	rm -rf /var/cache/apk/*

EXPOSE 9091

ENTRYPOINT ["/init"]

CMD ["/usr/bin/transmission-daemon", "--foreground" ]
