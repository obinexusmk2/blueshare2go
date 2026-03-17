#include "../core/blueshare_core.h"

#include <stdio.h>

int main(void) {
    const int rc = blueshare_initialize();
    if (rc != BLUESHARE_SUCCESS) {
        fprintf(stderr, "blueshare_initialize failed: %d\n", rc);
        return 1;
    }

    puts("BlueShare CLI initialized.");
    return 0;
}
