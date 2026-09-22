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
| [deepfake](https://github.com/r3dg0d/deepfake) | Research/VFX face-swap CLI (AlphaFace wrapper) | Python | Recommended | `pip install git+https://github.com/r3dg0d/deepfake` | v0.1.0 | [link](https://github.com/r3dg0d/deepfake) |
| [aivoice](https://github.com/r3dg0d/aivoice) | Real-time voice conversion (MeanVC2 wrapper) | Python | Recommended | `pip install git+https://github.com/r3dg0d/aivoice` | v0.1.0 | [link](https://github.com/r3dg0d/aivoice) |
| [metaclean](https://github.com/r3dg0d/metaclean) | Metadata inspect / scrub | Rust | No | `cargo install --git https://github.com/r3dg0d/metaclean` | v0.1.0 | [link](https://github.com/r3dg0d/metaclean) |
| [dnscheck](https://github.com/r3dg0d/dnscheck) | DNS privacy analyzer | Rust | No | `cargo install --git https://github.com/r3dg0d/dnscheck` | v0.1.0 | [link](https://github.com/r3dg0d/dnscheck) |
| [netidentity](https://github.com/r3dg0d/netidentity) | Network identity snapshot / diff | Rust | No | `cargo install --git https://github.com/r3dg0d/netidentity` | v0.1.0 | [link](https://github.com/r3dg0d/netidentity) |
| [fileshred](https://github.com/r3dg0d/fileshred) | Honest secure-delete (SSD/CoW aware) | Rust | No | `cargo install --git https://github.com/r3dg0d/fileshred` | v0.1.0 | [link](https://github.com/r3dg0d/fileshred) |
| [browserprivacy](https://github.com/r3dg0d/browserprivacy) | Read-only browser privacy audit | Rust | No | `cargo install --git https://github.com/r3dg0d/browserprivacy` | v0.1.0 | [link](https://github.com/r3dg0d/browserprivacy) |
| [opsec-check](https://github.com/r3dg0d/opsec-check) | Umbrella host OPSEC audit | Rust | No | `cargo install --git https://github.com/r3dg0d/opsec-check` | v0.1.0 | [link](https://github.com/r3dg0d/opsec-check) |

## NixOS

Each tool ships its own `flake.nix`. From this umbrella you can also:

```bash
nix flake show github:r3dg0d/privsec-tools
# package outputs mirror the tool names when flakes resolve
```

See `flake.nix` for the package set skeleton. Prefer installing individual
tool flakes for reproducibility:

```bash
nix profile install github:r3dg0d/macrandom
nix run github:r3dg0d/dnscheck -- status
```

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

Each repository tags `v0.1.0` with Linux binaries (Rust) or wheels/sdists (Python).

## License

Umbrella docs: MIT. Individual tools carry their own licenses (MIT or Apache-2.0 for our code; upstream research code may differ — see each NOTICE).
