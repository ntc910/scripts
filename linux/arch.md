# WSL

## temp set proxy
export http_proxy="http://107.98.150.183:3333"
export https_proxy="http://107.98.150.183:3333"
export HTTP_PROXY="http://107.98.150.183:3333"
export HTTPS_PROXY="http://107.98.150.183:3333"

sudo tee /etc/environment << 'EOF'
http_proxy="http://107.98.150.183:3333"
https_proxy="http://107.98.150.183:3333"
HTTP_PROXY="http://107.98.150.183:3333"
HTTPS_PROXY="http://107.98.150.183:3333"
no_proxy="localhost,127.0.0.1,localaddress"
NO_PROXY="localhost,127.0.0.1,localaddress"
EOF


## run pacman with proxy add -E
sudo -E pacman -S fish micro


## add user
useradd -m -G wheel nc
passwd nc
micro /etc/sudoers

```diff
--# %wheel ALL=(ALL:ALL) ALL
++%wheel ALL=(ALL:ALL) ALL
```

## set fish as default shell
chsh -s /usr/bin/fish # for root
chsh -s /usr/bin/fish nc

## update
sudo pacman -Syu

## proxy for fish
set -gx http_proxy http://107.98.150.183:3333
set -gx https_proxy http://107.98.150.183:3333
set -gx all_proxy http://107.98.150.183:3333

## AUR yay


## GPG proxy
mkdir -p ~/.gnupg
echo "http-proxy http://107.98.150.183:3333" >> ~/.gnupg/dirmngr.conf

gpgconf --kill dirmngr


## P4
yay -S p4
yay -S p4v

sudo pacman -S --needed nss libxi libxrender libxrandr libxcursor libxkbfile



sudo pacman -S --needed mesa lib32-mesa vulkan-swrast
