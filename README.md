# OpenVPN Client Container

This container is to be used an OpenVPN client.

The idea is to keep the image as agnostic as possible so we don't have to bake much into the image, that's why I am using the current config format set out in `/etc/openvpn`. This image gives you the ability to bring up multiple containers each with unique tunnels on the same host.


## Bit of an FYI


#### Volumes

The various OpenVPN files needed for the tunnels sit in `/etc/openvpn` on the host machine and that will need to be shared with the container when bring it up.

This is done via the `--volume` docker run option.


#### Privileged

In order for OpenVPN to do the various bits of networking magic you will need to use the `-privileged` docker run option, if not it'll fail to create the `/dev/tun` node or make amendments to iptables.


#### Tunnels

To define your tunnel you will need to use the `-t` flag that is part of the `openvpn.sh` script. `tun0` references an openvpn config file.

	-t tun0


## Running the container

The docker run command below shares the `/etc/openvpn` folder form the host machine with the container and then runs it in privileged mode. You are then specifying the image e.g. openvpn and selecting the config for the relevant tunnel you want it to bring u

	docker run -v /etc/openvpn:/etc/openvpn --privileged openvpn -t tun0


## Disclaimer

There are currently other and better working openvpn clients, but I wanted to have crack at it myself using Alpine linux. I used [dperson's](https://github.com/dperson) OpenVPN [client](https://github.com/dperson/openvpn-client) as reference so you will find a few similarities. 

This is super basic, and as it stands you are able to bring up a container that creates a tunnel using whatever config you specify using the `-t` option. 

Hope this helps whoever's poking around.
