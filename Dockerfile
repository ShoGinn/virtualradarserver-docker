FROM mono:latest

WORKDIR /opt/vrs

RUN \
	mkdir -p /opt/vrs \
	&& mkdir -p /config \
	&& mkdir -p /root/.local/share \
	&& ln -sf /config /root/.local/share/VirtualRadar

COPY ./start.sh start.sh

ADD ./logos.tar.gz /opt/vrs/Flags

ADD ./sideviews.tar.gz /opt/vrs/Silhouettes

VOLUME /config

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", "/opt/vrs/start.sh"]
