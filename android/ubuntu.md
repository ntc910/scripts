# Install
**NEED ROOT**
Get a rootfs [here](https://cdimage.ubuntu.com/ubuntu-base/releases/)

Termux is recommended.
<br>

Go to root shell
```sh
su
cd /data/local
mkdir ubuntu
cd ubuntu
```
Copy the rootfs then
```
tar xpf *.gz
```

Create a script to login.

```sh
vi ul.sh
```

```sh
#!/bin/sh
PATHS="/data/local/ubuntu"

mkdir -p $PATHS/dev
mkdir -p $PATHS/sys
mkdir -p $PATHS/proc
mkdir -p $PATHS/sdcard
mkdir -p $PATHS/dev/shm
mkdir -p $PATHS/dev/pts

busybox mount -o remount,dev,suid /data # Fix setuid issue
busybox mount --bind /dev $PATHS/dev
busybox mount --bind /sys $PATHS/sys
busybox mount --bind /proc $PATHS/proc
busybox mount -t devpts devpts $PATHS/dev/pts
busybox mount -t tmpfs -o size=256M tmpfs $PATHS/dev/shm
busybox mount --bind /sdcard $PATHS/sdcard

busybox chroot $PATHS /bin/su - root
```


Login with the script via `./ul.sh`
```sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "127.0.0.1 localhost" > /etc/hosts
```

fix Download is performed unsandboxed as root warning:

```sh
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root
```

update
```sh
apt update
apt upgrade

apt install vim net-tools sudo git
```

ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

groupadd storage
groupadd wheel

<!-- useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash user
passwd user -->

adduser nc
usermod -aG sudo nc

sudo apt install locales
sudo locale-gen en_US.UTF-8

sudo apt install openssh-client openssh-server

sudo apt install software-properties-common


# docker

sudo apt install ca-certificates curl gnupg

curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh

sudo dockerd &



sudo mkdir -p /sys/fs/cgroup
for d in cpuset cpu cpuacct blkio memory devices freezer net_cls perf_event net_prio hugetlb pids rdma; do
  sudo mkdir -p /sys/fs/cgroup/$d
  sudo mount -t cgroup -o $d cgroup /sys/fs/cgroup/$d
done