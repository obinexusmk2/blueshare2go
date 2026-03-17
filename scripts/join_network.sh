#!/bin/bash
# BlueShare network join script

set -euo pipefail

NETWORK_ID=""

print_help() {
    cat <<'HELP'
Usage: ./scripts/join_network.sh [OPTIONS]

Join an existing BlueShare network.

Options:
  --network-id VALUE      Network identifier to join
  --network-id=VALUE      Same as above
  -h, --help              Show this help message
HELP
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --network-id)
            [[ $# -ge 2 ]] || { echo "Missing value for --network-id"; exit 1; }
            NETWORK_ID="$2"
            shift 2
            ;;
        --network-id=*)
            NETWORK_ID="${1#*=}"
            shift
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_help
            exit 1
            ;;
    esac
done

if [[ -z "${NETWORK_ID}" ]]; then
    echo "--network-id is required"
    print_help
    exit 1
fi

echo "🔵 Joining BlueShare network ${NETWORK_ID}..."

./build/blueshare_cli join-network --network-id="${NETWORK_ID}"

echo "✅ Successfully joined network ${NETWORK_ID}"
