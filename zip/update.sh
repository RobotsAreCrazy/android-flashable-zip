#!/sbin/sh

# --- 1. SETUP BACKUP DIRECTORY ---
# Creates a folder on internal storage to save apps before deletion
BACKUP_DIR="/sdcard/Debloat_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
ui_print "- Backup folder created: $BACKUP_DIR"

# --- 2. THE BACKUP & REMOVE FUNCTION ---
# This replicates your original "Safe Remove" logic
safe_remove() {
    local TARGET_PATH="$1"
    if [ -d "$TARGET_PATH" ] || [ -f "$TARGET_PATH" ]; then
        ui_print "- Backing up & removing: $TARGET_PATH"
        # Copy to backup before removing (preserving permissions)
        cp -af "$TARGET_PATH" "$BACKUP_DIR/"
        rm -rf "$TARGET_PATH"
    else
        ui_print "- Skipped (not found): $TARGET_PATH"
    fi
}

# --- 3. THE DEBLOAT LIST ---
ui_print "Starting Samsung Deep Debloat..."

# Multimedia & Social
safe_remove "/product/priv-app/SamsungFree"
safe_remove "/system/app/SamsungTVPlus"
safe_remove "/product/app/SamsungKids"
safe_remove "/product/app/SamsungGlobalGoals"
safe_remove "/system/app/YouTubeMusic"
safe_remove "/system/app/Spotify"
safe_remove "/system/app/Facebook_installer"
safe_remove "/system/app/Facebook_services"

# Samsung Ecosystem & Apps
safe_remove "/system/priv-app/SamsungShop"
safe_remove "/system/app/SamsungMembers"
safe_remove "/system/app/SamsungNotes"
safe_remove "/system/app/SamsungCalendar"
safe_remove "/system/app/SamsungCloud"
safe_remove "/system/app/SamsungHealth"
safe_remove "/system/app/SamsungBilling"
safe_remove "/system/app/SBrowser" # Samsung Internet Browser

# Microsoft Integration (Common on A9+)
safe_remove "/system/app/OneDrive"
safe_remove "/system/app/Office_Hub"
safe_remove "/system/app/LinkedIn"

ui_print "--- Process Complete ---"
ui_print "All removed files are saved in $BACKUP_DIR"
