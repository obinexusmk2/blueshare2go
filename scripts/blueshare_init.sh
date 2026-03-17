#!/bin/bash
# BlueShare initialization helper

set -euo pipefail

echo "🔵 Initializing BlueShare service..."

# Build binaries and run baseline validation
./scripts/build.sh

echo "✅ BlueShare service initialized"
