#!/system/bin/sh
echo "=== Applying Edge Touch Fix ==="
if [ -e /proc/touchscreen/edge_report_limit ]; then
    echo algo_open:0 > /proc/touchscreen/edge_report_limit
    echo click_pixel:4 > /proc/touchscreen/edge_report_limit
    echo long_press_open:0 > /proc/touchscreen/edge_report_limit
    echo long_press_pixel:4,4,4,4 > /proc/touchscreen/edge_report_limit
    echo jitter_pixel:5 > /proc/touchscreen/edge_report_limit
    echo "[Success] Edge touch limits disabled."
    echo "--- Current Status ---"
    cat /proc/touchscreen/edge_report_limit | grep -E "algo_open|click_pixel|long_press_open|jitter_pixel"
else
    echo "[Error] /proc/touchscreen/edge_report_limit not found!"
fi
