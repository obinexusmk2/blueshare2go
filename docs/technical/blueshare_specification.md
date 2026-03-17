# BlueShare Technical Specification

## Purpose
BlueShare enables a user to create and share internet access with nearby devices,
with configurable topology and cost accounting per megabyte.

## CLI Script Interfaces

### `scripts/create_network.sh`
Creates a new network.

Supported options:
- `--topology VALUE` or `--topology=VALUE`
- `--duration SECONDS` or `--duration=SECONDS`
- `--cost-per-mb VALUE` or `--cost-per-mb=VALUE`
- `-h`, `--help`

### `scripts/join_network.sh`
Joins an existing network.

Supported options:
- `--network-id VALUE` or `--network-id=VALUE`
- `-h`, `--help`

### `scripts/blueshare_init.sh`
Initializes BlueShare by invoking `scripts/build.sh`.

## Runtime CLI Assumptions
Both create/join wrappers invoke `./build/blueshare_cli`:
- `create-network`
- `join-network`

The binary must be present in `build/` before use.
