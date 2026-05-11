
## Fix bug
dbus[10973]: Unable to set up transient service directory: XDG_RUNTIME_DIR "/mnt/wslg/runtime-dir" can be written by others (mode 040777)


```
# Sửa lỗi XDG_RUNTIME_DIR cho D-Bus và ứng dụng GUI
export USER_RUNTIME_DIR="/tmp/runtime-$USER"

if [ ! -d "$USER_RUNTIME_DIR" ]; then
    mkdir -p "$USER_RUNTIME_DIR"
    chmod 700 "$USER_RUNTIME_DIR"
fi

export XDG_RUNTIME_DIR="$USER_RUNTIME_DIR"
```

```
# Link Wayland socket từ WSLg vào thư mục runtime mới
if [ -S "/mnt/wslg/runtime-dir/wayland-0" ] && [ ! -S "$XDG_RUNTIME_DIR/wayland-0" ]; then
    ln -sf /mnt/wslg/runtime-dir/wayland-0 $XDG_RUNTIME_DIR/wayland-0
    ln -sf /mnt/wslg/runtime-dir/wayland-0.lock $XDG_RUNTIME_DIR/wayland-0.lock
fi
```

