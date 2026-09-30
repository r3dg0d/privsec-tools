# Tool matrix companion

The README table lists the tools, their purpose, install commands and reviewed
release versions. Follow each linked repository for current release details.

The Nix package set exposes these eight Rust tools on x86-64 and ARM64 Linux:
`macrandom`, `mullvadctl`, `dnscheck`, `netidentity`, `fileshred`, `metaclean`,
`browserprivacy`, and `opsec-check`. Exact source revisions are in `flake.lock`;
they can include maintenance commits newer than the published release tag.

The Python tools `fakeperson`, `deepfake`, and `aivoice` are catalog entries only.
