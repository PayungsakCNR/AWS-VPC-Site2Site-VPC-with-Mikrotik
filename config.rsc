# AWS VPC Site-to-Site VPN from AWS VPC to My Office Network
# Mikrotik RouterOS 6.45.6
# Payungsak Klinchampa | PaO
# Network/System/Cloud Engineer
# pao@payungsakpk.xyz
#
# This example use BGP Routing protocol,you can advertise Your office network with network command
# or Redistribute from another protocol
# 
# If you use a static route , please add static route by
# /ip route 
# add destination=<MY_AWS_VPC_PRIVATE_NETWORK> gateway=<Point-to-Point-AWS-IP-Tunnel-1> distance=10
# add destination=<MY_AWS_VPC_PRIVATE_NETWORK> gateway=<Point-to-Point-AWS-IP-Tunnel-2> distance=20

/ip address
add address=<Point-to-Point-AWS-IP-Tunnel-1>/30 interface=<WAN-Interface>
add address=<Point-to-Point-AWS-IP-Tunnel-2>/30 interface=<WAN-Interface>

/ip ipsec profile
add dh-group=modp1024 dpd-interval=10s dpd-maximum-failures=3 enc-algorithm=\
    aes-128 lifetime=8h name=profile1-aws nat-traversal=no

/ip ipsec peer
add address=<PEER1_AWS_PUBLIC_IP>/32 disabled=yes local-address=<OFFICE_WAN_PUBLIC_IP> name=\
    peer1-aws profile=profile1-aws
add address=<PEER2_AWS_PUBLIC_IP>/32 disabled=yes local-address=<OFFICE_WAN_PUBLIC_IP> name=\
    peer2-aws profile=profile1-aws

/ip ipsec proposal
add enc-algorithms=aes-128-cbc lifetime=1h name=ipsec-vpn-tunnel-1
add enc-algorithms=aes-128-cbc lifetime=1h name=ipsec-vpn-tunnel-2

/ip ipsec identity
add peer=peer1-aws secret=<tunnel-1-secret>
add peer=peer2-aws secret=<tunnel-2-secret>

/ip ipsec policy
add disabled=yes dst-address=<MY_OFFICE_PRIVATE_NETWORK> peer=peer1-aws proposal=\
    ipsec-vpn-08debffa46f808f6e-0 src-address=<MY_AWS_VPC_PRIVATE_NETWORK> tunnel=yes

add disabled=yes dst-address=<Point-to-Point-AWS-IP-Tunnel-1>/32 peer=peer1-aws proposal=\
    ipsec-vpn-08debffa46f808f6e-0 src-address=<Point-to-Point-Office-IP-Tunnel-1>/32 tunnel=yes

add disabled=yes dst-address=<Point-to-Point-AWS-IP-tunnel-2>/32 peer=peer2-aws proposal=\
    ipsec-vpn-08debffa46f808f6e-0 src-address=<Point-to-Point-Office-IP-Tunnel-2>/32 tunnel=yes

add disabled=yes dst-address=<MY_OFFICE_PRIVATE_NETWORK> peer=peer2-aws proposal=\
    ipsec-vpn-08debffa46f808f6e-1 src-address=<MY_AWS_VPC_PRIVATE_NETWORK> tunnel=yes


/routing bgp instance
set default as=<MY_OFFICE_PRIVATE_AS_NUMBER>

/routing bgp peer
add remote-as=<AWS-AS-NUMBER> hold-time=30s keepalive-time=10s name=AWS-Peer-1 remote-address=<Point-to-Point-AWS-IP-Tunnel-1>
add remote-as=<AWS-AS-NUMBER> hold-time=30s keepalive-time=10s name=AWS-Peer-2 remote-address=<Point-to-Point-AWS-IP-Tunnel-2>


/routing bgp network
add network=<MY_OFFICE_PRIVATE_NETWORK>
