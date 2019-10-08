# AWS-VPC-Site2Site-VPC-with-Mikrotik
AWS-VPC-Site2Site-VPC-with-Mikrotik


Example IP Address/Network Address/other config

<MY_AWS_VPC_PRIVATE_NETWORK> = 172.17.0.0/16
<MY_OFFICE_PRIVATE_NETWORK> = 172.16.0.0/16

<Point-to-Point-AWS-IP-Tunnel-1>/32 = 169.254.11.1/32
<Point-to-Point-AWS-IP-Tunnel-2>/32 = 169.254.12.1/32

<Point-to-Point-Office-IP-Tunnel-1>/32 = 169.254.11.2/32
<Point-to-Point-Office-IP-Tunnel-2>/32 = 169.254.12.2/32

<WAN-Interface> = ether1 , vlan10 , up to you


<tunnel-1-secret> = mycomplexSECRET-1@#$RTlf
<tunnel-2-secret> = mycomplexSECRET-1@#$NMKI

<AWS-AS-NUMBER> = 65531
<MY_OFFICE_PRIVATE_AS_NUMBER> = 65532
