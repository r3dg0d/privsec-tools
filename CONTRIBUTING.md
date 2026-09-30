# Contributing

This repository is an index. Open pull requests against the **individual tool**
repos listed in the README unless you are improving the umbrella catalog or flake.

For package-set changes, run `nix flake check --no-update-lock-file -L`. This
builds every tool and runs its tests plus help smoke checks. Native CI covers
both advertised Linux architectures. Update inputs explicitly with
`nix flake update <tool>` and review the lockfile diff.
