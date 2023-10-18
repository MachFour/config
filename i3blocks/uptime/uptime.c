#include <stdio.h>
#include <math.h>

// Returns time since system was powered on, in seconds.
// If /proc/uptime doesn't exist or can't be read, returns -1.
// Integer overflow will occur after around 68 years of uptime.
int get_uptime() {
    float uptime;
    FILE* proc_uptime_file = fopen("/proc/uptime", "r");
    if (proc_uptime_file == NULL) {
        return -1;
    }

    fscanf(proc_uptime_file, "%f", &uptime);
    return (int) lrintf(uptime);
}

// Prints out system uptime in one of the following formats:
// XXm, if the system uptime is less than 60 minutes
// XXh XXm, if the system uptime is less than 24 hours
// XXd XXh XXm, otherwise
int main() {
    int uptime = get_uptime();
    if (uptime == -1) {
        printf("oops\n");
    }
    int total_minutes = uptime / 60;
    int total_hours = total_minutes / 60;
    int minutes = total_minutes % 60;
    int hours = total_hours % 24;
    int days = total_hours / 24;

    if (days > 0) {
        printf("%dd %2dh %2dm\n", days, hours, minutes);
    } else if (hours > 0) {
        printf("%dh %2dm\n", hours, minutes);
    } else {
        printf("%dm\n", minutes);
    }

    return 0;
}
