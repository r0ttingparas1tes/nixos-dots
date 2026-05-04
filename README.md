# NixOS Dots

My personal NixOS configuration using flakes, split into modular system, desktop, and dev environments.

---

## Installation

### Existing host

For a system with a hostname matching an existing configuration:

```bash
mkdir -p ~/repos
git clone https://codeberg.org/r0tting_paras1tes/nixos-dots ~/repos/nixos-dots
sudo nixos-rebuild switch --flake ~/repos/nixos-dots#$(hostname)
```

---

### New system (no predefined host)

```bash
mkdir -p ~/repos
git clone https://codeberg.org/r0tting_paras1tes/nixos-dots ~/repos/nixos-dots
sudo nixos-rebuild switch --flake ~/repos/nixos-dots
```

---

## Structure

```
hosts/
  fraKctured/   → main laptop (dev)
  thrak/        → desktop machine (dev + gaming)
  starless/     → server (minimal setup)

modules/
  desktop/      → GUI + desktop environment modules
    niri/       → niri session + services
  dev/          → development tools and languages
```

---

## Notes

- No Home Manager
- Dotfiles are managed separately:
  https://codeberg.org/r0tting_paras1tes/dotfiles
```
