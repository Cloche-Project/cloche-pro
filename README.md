<p align="center">
  <picture>
    <img src="cloche-logo/watermark.png" alt="Cloche OS Logo" height="80" />
  </picture>
</p>

<p align="center">
    <strong>bootc Base Image</strong>
</p>

<p align="center">
  <strong>Cloche PRO</strong> is a minimal, container-native bootc image built on CentOS Stream, designed as the base layer for the Pro workstation variants.
</p>

<p align="center">
  <a href="https://github.com/cloche-project/cloche-pro/actions/workflows/build.yml">
    <img src="https://github.com/cloche-project/cloche-pro/actions/workflows/build.yml/badge.svg" alt="Build Status" />
  </a>
  <a href="https://ghcr.io/cloche-project/cloche-pro">
    <img src="https://img.shields.io/badge/registry-GHCR-blue?logo=github" alt="GHCR Registry" />
  </a>
  <img src="https://img.shields.io/github/license/cloche-project/cloche-pro" alt="License" />
</p>

> [!NOTE]
> **Cloche PRO uses a different deployment model from the rest of the Cloche family.** It is built on `bootc` over CentOS Stream rather than `rpm-ostree` over Fedora, and packages are installed with a plain `dnf install` inside the containerfile instead of a post-boot script. This is intentional — see the workspace-root `CLAUDE.md` for why.

---

## Role in the Cloche Family

This repository is not deployed directly as a workstation. It is the shared base image that [`cloche-pro-workstation`](https://github.com/cloche-project/cloche-pro-workstation) layers GNOME and KDE Plasma desktops on top of.

## Core Architecture

| Component | Details |
|-----------|---------|
| **Base Image** | `quay.io/centos-bootc/centos-bootc:stream10` |
| **Deployment Model** | `bootc` — container image *is* the bootable OS, no rpm-ostree layering |
| **Build System** | BlueBuild `containerfile` module, wrapping raw `dnf install` |
| **Container Integration** | Podman pre-installed |

## Key Features

* **CentOS Stream Foundation:** Tracks CentOS Stream 10, with EPEL and CRB enabled for a broader package set than the base repos alone.
* **Bootc-Native:** Updates and rollbacks are handled by `bootc`, not `rpm-ostree` — the same container image built here is what boots on disk.
* **Minimal Footprint:** No desktop environment or display manager; only the essentials (`fastfetch`, `newt`, `xorriso`, `podman`, `zsh`) plus the Starship prompt.

---

## Deployment & Installation

### Switching to Cloche PRO

`bootc` installations move between images with `bootc switch`, not `rpm-ostree rebase`:

```bash
sudo bootc switch ghcr.io/cloche-project/cloche-pro:latest
```

### Apply the change by rebooting:

```bash
systemctl reboot
```

> [!TIP]
> Most users should install a desktop variant of this image instead — see [`cloche-pro-workstation`](https://github.com/cloche-project/cloche-pro-workstation) for the GNOME and Plasma workstation builds.

---

## Verification & Security

Every image build is signed via Sigstore Cosign against the repository's public verification key.

```bash
cosign verify --key cosign.pub ghcr.io/cloche-project/cloche-pro:latest
```

## License & Acknowledgments

* Licensed under Apache 2.0
* Powered by the BlueBuild framework and the CentOS bootc images
