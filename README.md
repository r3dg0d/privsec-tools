# privsec-tools

Directory for a Linux-first **privacy / security / OPSEC** CLI toolkit.

Each tool is an **independent** open-source repository. This umbrella only
indexes them and optionally exposes a Nix package set. Install any tool on its
own — you do not need this repo.

> **Honesty:** these tools improve hygiene and situational awareness. They do
> **not** make you anonymous, untraceable, or perfectly secure.

## Tools

| Tool | Purpose | Language | GPU | Install | Version | Repo |
|------|---------|----------|-----|---------|---------|------|
| [macrandom](https://github.com/r3dg0d/macrandom) | MAC-address randomizer (NetworkManager-aware) | Rust | No | `cargo install --git https://github.com/r3dg0d/macrandom` | v0.1.0 | [link](https://github.com/r3dg0d/macrandom) |
| [mullvadctl](https://github.com/r3dg0d/mullvadctl) | Companion helpers for official Mullvad CLI | Rust | No | `cargo install --git https://github.com/r3dg0d/mullvadctl` | v0.1.0 | [link](https://github.com/r3dg0d/mullvadctl) |
| [fakeperson](https://github.com/r3dg0d/fakeperson) | Photorealistic fictional people + synthetic identities | Python | Optional (CUDA via `text2img`) | `pip install git+https://github.com/r3dg0d/fakeperson` | v0.1.0 | [link](https://github.com/r3dg0d/fakeperson) |
| [deepfake](https://github.com/r3dg0d/deepfake) | Research/VFX face-swap CLI (AlphaFace wrapper) | Python | Recommended | `pip install git+https://github.com/r3dg0d/deepfake` | v0.2.1 | [link](https://github.com/r3dg0d/deepfake) |
| [aivoice](https://github.com/r3dg0d/aivoice) | Real-time voice conversion (MeanVC2 wrapper) | Python | Recommended | `pip install git+https://github.com/r3dg0d/aivoice` | v0.3.0 | [link](https://github.com/r3dg0d/aivoice) |
| [metaclean](https://github.com/r3dg0d/metaclean) | Metadata inspect / scrub | Rust | No | `cargo install --git https://github.com/r3dg0d/metaclean` | v0.1.0 | [link](https://github.com/r3dg0d/metaclean) |
| [dnscheck](https://github.com/r3dg0d/dnscheck) | DNS privacy analyzer | Rust | No | `cargo install --git https://github.com/r3dg0d/dnscheck` | v0.1.0 | [link](https://github.com/r3dg0d/dnscheck) |
| [netidentity](https://github.com/r3dg0d/netidentity) | Network identity snapshot / diff | Rust | No | `cargo install --git https://github.com/r3dg0d/netidentity` | v0.1.0 | [link](https://github.com/r3dg0d/netidentity) |
| [fileshred](https://github.com/r3dg0d/fileshred) | Honest secure-delete (SSD/CoW aware) | Rust | No | `cargo install --git https://github.com/r3dg0d/fileshred` | v0.1.0 | [link](https://github.com/r3dg0d/fileshred) |
| [browserprivacy](https://github.com/r3dg0d/browserprivacy) | Read-only browser privacy audit | Rust | No | `cargo install --git https://github.com/r3dg0d/browserprivacy` | v0.1.0 | [link](https://github.com/r3dg0d/browserprivacy) |
| [opsec-check](https://github.com/r3dg0d/opsec-check) | Umbrella host OPSEC audit | Rust | No | `cargo install --git https://github.com/r3dg0d/opsec-check` | v0.1.0 | [link](https://github.com/r3dg0d/opsec-check) |

## NixOS

The eight Rust tools are available on `x86_64-linux` and `aarch64-linux`.
This umbrella commits `flake.lock` to pin its tool sources and Nix dependencies;
builds use those reviewed revisions until the lockfile is explicitly updated.
Each tool remains independently installable.

```bash
nix flake show github:r3dg0d/privsec-tools
nix build github:r3dg0d/privsec-tools#dnscheck
nix run github:r3dg0d/privsec-tools#dnscheck -- --help
nix run github:r3dg0d/privsec-tools#opsec-check -- --help
nix profile install github:r3dg0d/privsec-tools#macrandom
```

The default package contains documentation. Select a named tool to build or run
it. `opsec-check` is the existing host-audit CLI; this repository adds no separate
audit implementation. Python AI tools in the catalog are installed from their
own repositories, not from this Nix package set.

## Package checks

```bash
nix flake check --no-update-lock-file -L
```

This builds all eight Rust packages, runs their package tests and executes each
installed CLI with `--help`. CI runs these checks on native x86-64 and ARM64 Linux
runners. Help smoke checks do not audit or modify host state; they do not establish
that privileged operations, live network tools or browser audits work on every
machine.

Maintainers update individual tool inputs explicitly, for example:

```bash
nix flake update dnscheck
nix flake check --no-update-lock-file -L
```

Review the lockfile diff and resulting package tests before committing the
update. Tool changes are made in the individual repositories first.

## AI / model note

`fakeperson`, `deepfake`, and `aivoice` **never** silently download giant
weights. Use each tool's `models list` / `models install … --yes` after
reviewing upstream licenses.

- **fakeperson** prefers a local `text2img` (LLaDA-Image) service when present.
- **deepfake** wraps [AlphaFace](https://arxiv.org/abs/2601.16429) (MIT code; Drive weights undocumented — not redistributed).
- **aivoice** wraps [MeanVC2](https://arxiv.org/abs/2606.09050) (HF weights; upstream LICENSE file gap documented in NOTICE).

Synthetic-media tools are framed for research, VFX, avatars, filmmaking, and
**disclosed** synthetic media — not anonymity.

## Releases

Release versions vary by repository. See each tool’s GitHub Releases for its
current binaries or Python wheels/sdists; catalog versions are reviewed snapshots.

## License

Umbrella docs: MIT. Individual tools carry their own licenses (MIT or Apache-2.0 for our code; upstream research code may differ — see each NOTICE).
