

# ip address show        befor docker start 2 after docker start 3

# docker network ls 

# docker run -itd --rm --name  thor busybox
# docker run -itd --rm --name  mjolnir busybox
# docker run -itd --rm --name  stormbreaker nginx

# bridge link command,
#  which shows the status of virtual Ethernet (veth) pairs associated 
# with a Docker bridge network (likely docker0)

# bridge link
#     5: vetha7092ca@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2
#     7: veth945757c@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2
#     9: veth029fdda@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2

# docker inspect bridge 



# docker exec -it thor sh

# ip add
#      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#        valid_lft forever preferred_lft forever
#     4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue
#         link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
#         inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
#         valid_lft forever preferred_lft forever
# ping 172.17.0.3



# user defined network
# --------------------
# docker network create asgard

# docker run -itd --rm --network asgard --name  loki busybox
# docker run -itd --rm --network asgard --name  odin busybox
#  bridge link
#     5: vetha7092ca@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2
#     7: veth945757c@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2
#     9: veth029fdda@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master docker0 state forwarding priority 32 cost 2
#     12: veth8f25980@if11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br-5031937a7d46 state forwarding priority 32 cost 2
#     14: veth7219cf2@if13: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br-5031937a7d46 state forwarding priority 32 cost 2


