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
no_proxy="localhost,127.0.0.1,localaddress,.samsung.net,.secsso.net,ipaas-mcp.sec.samsung.net,.samsung.com,.samsungif.com"
NO_PROXY="localhost,127.0.0.1,localaddress,.samsung.net,.secsso.net,ipaas-mcp.sec.samsung.net,.samsung.com,.samsungif.com"
EOF


## Ignore ssl with http proxy
sed -i 's|#XferCommand = /usr/bin/curl|XferCommand = /usr/bin/curl -k|' /etc/pacman.conf


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


# Fix GUI

1. must have prefix
dbus-run-session nautilus

2. config fish:
```sh
if status is-interactive
    set -U fish_greeting ""
    set -gx http_proxy http://107.98.150.183:3333
    set -gx https_proxy http://107.98.150.183:3333
    set -gx all_proxy http://107.98.150.183:3333
    set -gx no_proxy "*.samsung.net,*.secsso.net,ipaas-mcp.sec.samsung.net,*.samsung.com,*.samsungif.com"

    set -gx HTTP_PROXY $http_proxy
    set -gx HTTPS_PROXY $https_proxy
    set -gx ALL_PROXY $all_proxy
    set -gx NO_PROXY $no_proxy

    # GUI
    set -gx GALLIUM_DRIVER zink
    set -gx MESA_LOADER_DRIVER_OVERRIDE d3d12
    
    set -gx GDK_SCALE 1
    set -gx GDK_DPI_SCALE 1
    set -gx XDG_CURRENT_DESKTOP GNOME
    set -gx XDG_RUNTIME_DIR /run/user/(id -u)
        
    set -gx GDK_BACKEND x11
    set -gx XDG_SESSION_TYPE x11

    set -gx MESA_LOADER_DRIVER_OVERRIDE swrast
    set -gx GALLIUM_DRIVER llvmpipe
    set -gx GVFS_DISABLE_FUSE 1
    set -gx GIO_USE_VFS local

    # alias nautilus="dbus-run-session nautilus"
    # alias gnome-control-center="dbus-run-session gnome-control-center"
    # alias gnome-tweaks="dbus-run-session gnome-tweaks"
end

alias codium='/mnt/d/HQ_APKFiles/Programs/VSCodium/bin/codium'

```
