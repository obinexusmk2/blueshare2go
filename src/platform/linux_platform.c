#include "platform_interface.h"

#include <string.h>

int platform_init_bluetooth(void) { return BLUESHARE_SUCCESS; }
int platform_enable_hotspot(const char* ssid, const char* password) {
    return (ssid != NULL && password != NULL) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_DEVICE_NOT_FOUND;
}
int platform_get_device_usage(const uint8_t* device_mac, usage_statistics_t* stats) {
    if (device_mac == NULL || stats == NULL) {
        return BLUESHARE_ERROR_DEVICE_NOT_FOUND;
    }
    memset(stats, 0, sizeof(*stats));
    memcpy(stats->device_mac, device_mac, sizeof(stats->device_mac));
    return BLUESHARE_SUCCESS;
}
int platform_route_traffic(const uint8_t* client_mac, const void* data, size_t data_len) {
    (void)data;
    return (client_mac != NULL && data_len > 0U) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_DEVICE_NOT_FOUND;
}
int platform_cleanup(void) { return BLUESHARE_SUCCESS; }

int platform_bluetooth_scan(blueshare_device_t* devices, size_t max_devices) {
    (void)devices;
    return max_devices > 0U ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_NO_SLOTS;
}
int platform_bluetooth_pair(const uint8_t* target_mac, const char* passkey) {
    return (target_mac != NULL && passkey != NULL) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_DEVICE_NOT_FOUND;
}
int platform_bluetooth_advertise(const char* device_name, uint32_t available_bandwidth) {
    return (device_name != NULL && available_bandwidth > 0U) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_NO_SLOTS;
}

int platform_create_access_point(const char* ssid, const char* password) {
    return (ssid != NULL && password != NULL) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_DEVICE_NOT_FOUND;
}
int platform_get_connected_clients(uint8_t clients[][6], size_t max_clients) {
    (void)clients;
    return max_clients > 0U ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_NO_SLOTS;
}
int platform_set_bandwidth_limit(const uint8_t* client_mac, uint32_t limit_kbps) {
    return (client_mac != NULL && limit_kbps > 0U) ? BLUESHARE_SUCCESS : BLUESHARE_ERROR_NO_SLOTS;
}
