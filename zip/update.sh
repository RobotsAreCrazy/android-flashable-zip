#!/sbin/sh

# 1. Setup Backup Directory on Internal Storage
# This creates a folder with a timestamp so you don't overwrite old backups
BACKUP_DIR="/sdcard/Debloat_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
ui_print "- Backup folder created: $BACKUP_DIR"

# 2. Define the Backup & Remove function
# This function handles the "copy then delete" logic
safe_remove() {
    local TARGET_PATH="$1"
    if [ -d "$TARGET_PATH" ]; then
        ui_print "- Backing up & removing: $TARGET_PATH"
        # cp -af preserves permissions and attributes
        cp -af "$TARGET_PATH" "$BACKUP_DIR/"
        rm -rf "$TARGET_PATH"
    else
        ui_print "- Skipped (not found): $TARGET_PATH"
    fi
}

# 3. Starting the Debloat process
ui_print "Starting Samsung Debloat..."

# Add or remove folder paths based on what you found in your file manager
safe_remove "/product/priv-app/SamsungFree"
safe_remove "/system/app/SamsungTVPlus"
safe_remove "/product/app/SamsungKids"
safe_remove "/product/app/SamsungGlobalGoals"
safe_remove "/system/priv-app/SamsungShop"

ui_print "--- Process Complete ---"
ui_print "- Files backed up to: $BACKUP_DIR"
