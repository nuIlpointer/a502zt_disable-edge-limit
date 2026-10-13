SKIPUNZIP=0

ui_print "****************************************"
ui_print "*   ZTE/nubia Fold Edge Limit Fix      *"
ui_print "*        by nuIlpointer                *"
ui_print "****************************************"

# Check if target node exists
if [ -e /proc/touchscreen/edge_report_limit ]; then
    ui_print "- Detected /proc/touchscreen/edge_report_limit"
else
    ui_print "! Warning: /proc/touchscreen/edge_report_limit not found."
    ui_print "! This module is intended for ZTE/nubia Fold (A502ZT / Z9900S)."
fi

# Set permissions
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/action.sh 0 0 0755

ui_print "- Installation complete!"
