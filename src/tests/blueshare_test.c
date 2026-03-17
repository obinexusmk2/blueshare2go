#include "../core/blueshare_core.h"

#include <stdio.h>

int main(void) {
    blueshare_network_t network;

    if (blueshare_initialize() != BLUESHARE_SUCCESS) {
        fprintf(stderr, "initialize failed\n");
        return 1;
    }

    if (blueshare_create_network(&network, TOPOLOGY_STAR) != BLUESHARE_SUCCESS) {
        fprintf(stderr, "create_network failed\n");
        return 1;
    }

    puts("BlueShare smoke test passed.");
    return 0;
}
