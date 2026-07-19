# NixOS flake

One flake contains the `think-nix` workstation, the `homelab` server, and a
small remote-bootstrap ISO. All systems currently target `x86_64-linux` and use
the same locked nixpkgs revision.

## Outputs

| Output | Purpose |
| --- | --- |
| `nixosConfigurations.think-nix` | Workstation with its Home Manager configuration |
| `homeConfigurations."mitchanx@think-nix"` | Optional standalone Home Manager activation |
| `nixosConfigurations.homelab` | Headless homelab server installed with disko |
| `nixosConfigurations.nixos-bootstrap` | Configuration behind the bootstrap ISO |
| `packages.x86_64-linux.iso` | Bootable bootstrap ISO |

Inspect and check everything:

```console
nix flake show
nix flake check --no-build
```

Rebuild the workstation:

```console
sudo nixos-rebuild switch --flake .#think-nix
```

Build the ISO:

```console
nix build .#iso
```

The ISO enables root autologin on its console and root SSH access only through
the public key in `keys/mitchanx-think-nix.pub`. It includes Git and disko.

## Homelab installation

`hosts/homelab/disko.nix` **erases its target disk**. It defaults to `/dev/sda`.
Confirm the device name with `lsblk` before running it, and override `device` in
the module when necessary.

From an installer environment:

```console
sudo nix run github:nix-community/disko -- \
  --mode disko ./hosts/homelab/disko.nix
sudo nixos-install --flake .#homelab --root /mnt --no-root-passwd
```

The configuration uses an 8 GiB swap partition instead of the previous
manually-created swap file. SSH password login is disabled. The `mitchanx` user
has passwordless sudo because the account itself is key-only.

The data disk mounted at `/mnt/hdd` is intentionally outside disko so a system
reinstall cannot format it. Its UUID remains host-specific in
`hosts/homelab/hardware-configuration.nix`.

## Repository layout

- `hosts/` contains hardware, storage, boot, identity, and state-version
  decisions unique to a deployed machine.
- `profiles/` composes reusable modules into complete workstation and server
  roles.
- `modules/nixos/common/` contains baseline Nix, locale, and package policy.
- `modules/nixos/users/` and `modules/nixos/services/` contain reusable account
  and service capabilities.
- `modules/nixos/desktop/` contains desktop capabilities independently of the
  `think-nix` hardware.
- `images/` contains image-only configuration.
- `keys/` contains public SSH keys only; private keys and VPN credentials must
  not be committed.

Host definitions should stay thin. For example, a new server can import
`profiles/server.nix`, then add only its hardware configuration, disko layout,
hostname-specific storage, and `system.stateVersion`. The `mkSystem` helper in
`flake.nix` accepts per-host `system` and `user` values, so future ARM machines
or machines with a different administrator do not require global changes.

The old WireGuard and OpenVPN declarations referenced files that the flake could
not produce under `/etc`. They were inactive and have been removed. Import VPN
connections through NetworkManager for local runtime use. If they later need to
be deployed declaratively, add encrypted `sops-nix` secrets rather than putting
private keys or provider profiles in the Nix store.

`think-nix` does not use disko. Its current NVMe disk contains Windows, recovery,
EFI, XBOOTLDR, and NixOS partitions. A whole-disk disko layout would put those
existing partitions at risk; converting it should only happen after deciding on
an explicit dual-boot partition migration and taking a backup.
