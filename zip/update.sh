#!/sbin/sh

# --- 1. SETUP BACKUP DIRECTORY ---
BACKUP_DIR="/sdcard/Debloat_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
ui_print "- Backup folder created: $BACKUP_DIR"

# --- 2. THE BACKUP & REMOVE FUNCTION ---
safe_remove() {
    local TARGET_PATH="$1"
    if [ -d "$TARGET_PATH" ] || [ -f "$TARGET_PATH" ]; then
        ui_print "- Backing up & removing: $TARGET_PATH"
        cp -af "$TARGET_PATH" "$BACKUP_DIR/"
        rm -rf "$TARGET_PATH"
    else
        ui_print "- Skipped (not found): $TARGET_PATH"
    fi
}

# --- 3. THE ULTIMATE DEBLOAT LIST ---
ui_print "Starting Total Cleanse (Keeping Play Store)..."

# --- GOOGLE 'CRAP' (Minus Play Store/Services) ---
safe_remove "/system/app/Google"               # Google Search App
safe_remove "/system/app/Chrome"               # Heavy RAM user
safe_remove "/system/app/YouTube"              
safe_remove "/system/app/Drive"                
safe_remove "/system/app/Maps"                 
safe_remove "/system/app/Photos"               
safe_remove "/system/app/Gmail2"               
safe_remove "/system/app/Duo"                  
safe_remove "/system/app/GoogleTTS"            
safe_remove "/system/app/Music2"               
safe_remove "/system/app/Videos"               
safe_remove "/system/app/Keep"                 
safe_remove "/system/app/Books"
safe_remove "/system/app/Magazines"

# --- BIXBY & AR FEATURES ---
safe_remove "/system/priv-app/BixbyWakeup"
safe_remove "/system/app/BixbyService"
safe_remove "/system/priv-app/BixbyAgent"
safe_remove "/system/app/ArZone"
safe_remove "/system/app/AREmoji"
safe_remove "/system/app/AREmojiEditor"

# --- SAMSUNG & MICROSOFT ---
safe_remove "/product/priv-app/SamsungFree"
safe_remove "/system/app/SamsungTVPlus"
safe_remove "/product/app/SamsungKids"
safe_remove "/product/app/SamsungGlobalGoals"
safe_remove "/system/app/OneDrive"
safe_remove "/system/app/Office_Hub"
safe_remove "/system/app/LinkedIn"
safe_remove "/system/app/Facebook_installer"
safe_remove "/system/app/Facebook_services"

ui_print "--- Total Cleanse Complete ---"
ui_print "Check $BACKUP_DIR for your backups."
