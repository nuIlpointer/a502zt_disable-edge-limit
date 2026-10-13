#!/system/bin/sh
# Wait until boot completed
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done
sleep 3

apply_edge_fix() {
    if [ -e /proc/touchscreen/edge_report_limit ]; then
        echo algo_open:0 > /proc/touchscreen/edge_report_limit
        echo click_pixel:4 > /proc/touchscreen/edge_report_limit
        echo long_press_open:0 > /proc/touchscreen/edge_report_limit
        echo long_press_pixel:4,4,4,4 > /proc/touchscreen/edge_report_limit
        echo jitter_pixel:5 > /proc/touchscreen/edge_report_limit
    fi
}

# Apply fix on boot
apply_edge_fix

# Daemon to reapply fix whenever fold state changes
LAST_FOLD=""
while true; do
    CUR_FOLD="$(getprop persist.vendor.fold.display 2>/dev/null):$(cat /proc/touchscreen/fold_state 2>/dev/null)"
    if [ "$CUR_FOLD" != "$LAST_FOLD" ]; then
        sleep 1
        apply_edge_fix
        LAST_FOLD="$CUR_FOLD"
    fi
    sleep 5
done &
