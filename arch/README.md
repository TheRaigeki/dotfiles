# arch

System setup that stow cannot install. Stow skips this README, so it never ends up in `~`.

## F4 mic-mute LED (ThinkPad P14s Gen 7 AMD)

### Problem

The LED on F4 is always lit, even when the microphone is on.

The kernel ties the LED (`/sys/class/leds/platform::micmute`) to the capture switch of the headset jack on the HDA codec. The mic that is actually in use is the internal digital mic (`acppdmmach`, AMD ACP). It has no hardware mute, so PipeWire mutes it in software, and the LED never finds out.

### How it is fixed

- `hyprland/.local/bin/micmute-led` detaches the LED from the kernel trigger. It then follows the mute state of the default PipeWire source through `pactl subscribe`. That covers F4, `wpctl`, apps that mute the system source, and switching the default mic.
- `hyprland/.config/systemd/user/micmute-led.service` starts it with the graphical session.
- The udev rule below lets your user write the LED. The LED files in `/sys` belong to root, and the rule gives group `wheel` write access to `trigger` and `brightness`. It changes nothing else.

### Setup on a fresh install

1. Install the udev rule (needs sudo) and apply it right away:

   ```bash
   sudo tee /etc/udev/rules.d/90-micmute-led.rules >/dev/null <<'EOF'
   # Let the logged-in user drive the mic-mute LED (see ~/.local/bin/micmute-led).
   ACTION=="add", SUBSYSTEM=="leds", KERNEL=="platform::micmute", RUN+="/usr/bin/chgrp wheel /sys%p/trigger /sys%p/brightness", RUN+="/usr/bin/chmod 0664 /sys%p/trigger /sys%p/brightness"
   EOF
   sudo udevadm control --reload
   sudo udevadm trigger --action=add /sys/class/leds/platform::micmute
   ```

   Your user has to be in `wheel`. Check with `id`.

2. Stow the hyprland package, if you have not already:

   ```bash
   cd ~/dotfiles && stow hyprland
   ```

3. Enable the service. The enable link lives in `~/.config` and is not part of the dotfiles:

   ```bash
   systemctl --user daemon-reload
   systemctl --user enable --now micmute-led.service
   ```

### Check

```bash
ls -l /sys/class/leds/platform::micmute/{trigger,brightness}   # group wheel, -rw-rw-r--
systemctl --user status micmute-led.service                     # active (running)
```

Press F4 twice. The LED should be on while the mic is muted and off while it is live.

### Undo

```bash
systemctl --user disable --now micmute-led.service
sudo rm /etc/udev/rules.d/90-micmute-led.rules
```

After a reboot the kernel drives the LED again (always lit).
