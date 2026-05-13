#!/sbin/sh

# 1. Setup Backup Directory on internal storage
# This creates a folder with the current date/time
BACKUP_DIR="/sdcard/Debloat_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
ui_print "- Backup folder created: $BACKUP_DIR"

# 2. Define the Backup & Remove function
safe_remove() {
    local TARGET_PATH="$1"
    if [ -d "$TARGET_PATH" ]; then
        ui_print "- Backing up & removing: $TARGET_PATH"
        # Copy the folder to backup before deleting it
        cp -af "$TARGET_PATH" "$BACKUP_DIR/"
        rm -rf "$TARGET_PATH"
    else
        ui_print "- Skipped (not found): $TARGET_PATH"
    fi
}

# 3. List your targets (Based on Samsung common bloat)
ui_print "Starting Debloat..."

safe_remove "/product/priv-app/SamsungFree"
safe_remove "/system/app/SamsungTVPlus"
safe_remove "/product/app/SamsungKids"
safe_remove "/product/app/SamsungGlobalGoals"

ui_print "--- Process Complete ---"
ui_print "Check $BACKUP_DIR for your files."
