FROM alpine:3.3

# Installs OpenVPN and various dependencies
RUN apk add --update openvpn \
    iptables \
	&& rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

# Adds run script to start openvpn
ADD ./files/sbin /usr/local/sbin
RUN chmod a+x /usr/local/sbin/*

VOLUME ["/etc/openvpn"]

ENTRYPOINT ["openvpn.sh"]