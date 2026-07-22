# NixOS & Home Manager Dotfiles

Modular NixOS and Home Manager configuration managed via Nix Flakes, supporting multiple profiles (**Personal Desktop** and **WSL**).

---

## Profiles

The repository supports two primary profiles:

| Profile | Target Environment | 
| :--- | :--- | 
| `personal` | Native NixOS Desktop | 
| `wsl` | NixOS inside WSL2 | 

---

## Usage 

### 1. Initial Setup / Cloning

Clone the repository into your home directory:

```bash
git clone https://github.com/januarpancaran/nix-dots.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Building & Applying System Configurations

#### Using `nixos-rebuild`

* **Personal Desktop Profile:**
  ```bash
  sudo nixos-rebuild switch --flake .#personal
  ```

* **WSL Profile:**
  ```bash
  sudo nixos-rebuild switch --flake .#wsl
  ```

#### Using `nh` (Nix Helper)

If `nh` is installed, you can conveniently build and apply using:

```bash
nh os switch .#personal
# or for WSL:
nh os switch .#wsl
```

---

### 3. Building & Applying Home Manager Configurations

#### Using `home-manager`

* **Personal Profile:**
  ```bash
  home-manager switch --flake .#personal
  ```

* **WSL Profile:**
  ```bash
  home-manager switch --flake .#wsl
  ```

#### Using `nh`

```bash
nh home switch .#personal
# or for WSL:
nh home switch .#wsl
```

---

## Customization

### Modifying Shared User & Profile Settings

All top-level settings are centralized in [`flake.nix`](file:///home/daangsangu/.dotfiles/flake.nix):

* **`userSettings`**: Global user options (`username`, `gitUsername`, `gitEmail`, `defaultShell`, enabled browsers, etc.).
* **`personalSettings`**: Options specific to the desktop profile (bootloader, GPU drivers, optional features like `enableSteam`, `enableAndroidDev`, `enableVM`).
* **`wslSettings`**: Options specific to the WSL profile (`enableContainers`, `enableMySQL`, `enablePostgreSQL`).

### Adding or Registering Modules

This repository uses an **Auto-Import Registry** system:

1. Create your Nix module under `system/` or `user/`.
2. Register the module in [`modules/system.nix`](file:///home/daangsangu/.dotfiles/modules/system.nix) or [`modules/home.nix`](file:///home/daangsangu/.dotfiles/modules/home.nix):

```nix
{ path = ../system/services/my-service.nix; profiles = [ "personal" "wsl" ]; }
```

The profile's `configuration.nix` / `home.nix` will automatically load all modules registered for its profile target.
