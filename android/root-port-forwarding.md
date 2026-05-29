# 

sysctl -w net.ipv4.ip_forward=1

iptables -t nat -A PREROUTING -p tcp --dport 47984 -j DNAT --to-destination 100.99.1.1:47984
iptables -t nat -A PREROUTING -p tcp --dport 47989 -j DNAT --to-destination 100.99.1.1:47989
iptables -t nat -A PREROUTING -p tcp --dport 47990 -j DNAT --to-destination 100.99.1.1:47990
iptables -t nat -A PREROUTING -p tcp --dport 48010 -j DNAT --to-destination 100.99.1.1:48010

iptables -t nat -A PREROUTING -p udp --dport 47998 -j DNAT --to-destination 100.99.1.1:47998
iptables -t nat -A PREROUTING -p udp --dport 47999 -j DNAT --to-destination 100.99.1.1:47999
iptables -t nat -A PREROUTING -p udp --dport 48000 -j DNAT --to-destination 100.99.1.1:48000
iptables -t nat -A PREROUTING -p udp --dport 48002 -j DNAT --to-destination 100.99.1.1:48002
iptables -t nat -A PREROUTING -p udp --dport 48010 -j DNAT --to-destination 100.99.1.1:48010




-__
iptables -t nat -A POSTROUTING -p udp -d 100.99.1.1 --dport 47998:48010 -j MASQUERADE

iptables -t nat -A PREROUTING -p udp --dport 47984 -j DNAT --to-destination 100.99.1.1


iptables -t nat -A POSTROUTING -p udp -d 100.99.1.1 --dport 47998:48010 -j MASQUERADE


iptables -t nat -A PREROUTING -p udp --dport 55555 -j DNAT --to-destination 100.99.5.5:55555


socat TCP-LISTEN:55555,fork,reuseaddr TCP:100.99.5.5:55555 &