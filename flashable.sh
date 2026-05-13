# Setup backup directory on internal storage
BACKUP_DIR="/sdcard/Debloat_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
ui_print "- Backup folder: $BACKUP_DIR"

# Function to backup and then physically remove the app
safe_remove() {
    local APP_PATH="$1"
    if [ -d "$APP_PATH" ]; then
        ui_print "- Backing up & removing: $APP_PATH"
        # Copy the whole folder to backup before deleting
        cp -af "$APP_PATH" "$BACKUP_DIR/"
        rm -rf "$APP_PATH"
    else
        ui_print "- Skipped (not found): $APP_PATH"
    fi
}

# --- LIST YOUR TARGETS HERE ---
# Use folder paths confirmed via OrangeFox File Manager
safe_remove "/product/priv-app/SamsungFree"
safe_remove "/system/app/SamsungTVPlus"
safe_remove "/product/app/SamsungKids"

ui_print "- Debloat and Backup complete!"
