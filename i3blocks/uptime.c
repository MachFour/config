#include <stdio.h>
#include <math.h>

// Returns time since system was powered on, in seconds.
// If /proc/uptime doesn't exist or can't be read, returns -1.
long get_uptime() {
    float uptime;
    FILE* proc_uptime_file = fopen("/proc/uptime", "r");
    if (proc_uptime_file == NULL) {
        return -1;
    }

    fscanf(proc_uptime_file, "%f", &uptime);
    return lrintf(uptime);
}

void main() {
    int total_minutes = (int) (get_uptime() / 60L);
    int total_hours = total_minutes / 60;
    int minutes = total_minutes % 60;
    int hours = total_hours % 24;
    int days = total_hours / 24;

    if (days > 0) {
        printf("%dd %2dh %2dm\n", days, hours, minutes);
    } else if (hours > 0) {
        printf("%2dh %2dm\n", hours, minutes);
    } else {
        printf("%2dm\n", minutes);
    }
}
