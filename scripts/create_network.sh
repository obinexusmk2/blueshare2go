#!/bin/bash
# BlueShare Network Creation Script

set -euo pipefail

# Default parameters
TOPOLOGY="star"
DURATION=3600
COST_PER_MB=100  # microsatoshis

print_help() {
    cat <<'HELP'
Usage: ./scripts/create_network.sh [OPTIONS]

Create a BlueShare network.

Options:
  --topology VALUE        Network topology (star|bus|mesh|hybrid)
  --topology=VALUE        Same as above
  --duration SECONDS      Network duration in seconds
  --duration=SECONDS      Same as above
  --cost-per-mb VALUE     Cost per MB in microsatoshis
  --cost-per-mb=VALUE     Same as above
  -h, --help              Show this help message
HELP
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --topology)
            [[ $# -ge 2 ]] || { echo "Missing value for --topology"; exit 1; }
            TOPOLOGY="$2"
            shift 2
            ;;
        --topology=*)
            TOPOLOGY="${1#*=}"
            shift
            ;;
        --duration)
            [[ $# -ge 2 ]] || { echo "Missing value for --duration"; exit 1; }
            DURATION="$2"
            shift 2
            ;;
        --duration=*)
            DURATION="${1#*=}"
            shift
            ;;
        --cost-per-mb)
            [[ $# -ge 2 ]] || { echo "Missing value for --cost-per-mb"; exit 1; }
            COST_PER_MB="$2"
            shift 2
            ;;
        --cost-per-mb=*)
            COST_PER_MB="${1#*=}"
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

echo "🔵 Creating BlueShare network..."
echo "   Topology: ${TOPOLOGY}"
echo "   Duration: ${DURATION} seconds"
echo "   Cost per MB: ${COST_PER_MB} microsatoshis"

# Validate topology
case ${TOPOLOGY} in
    "star"|"bus"|"mesh"|"hybrid")
        echo "✅ Valid topology: ${TOPOLOGY}"
        ;;
    *)
        echo "❌ Invalid topology: ${TOPOLOGY}"
        echo "Valid options: star, bus, mesh, hybrid"
        exit 1
        ;;
esac

# Create network using BlueShare API
./build/blueshare_cli create-network \
    --topology=${TOPOLOGY} \
    --duration=${DURATION} \
    --cost-per-mb=${COST_PER_MB}

echo "✅ BlueShare network created successfully"
