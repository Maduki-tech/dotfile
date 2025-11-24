#!/bin/bash
# Script to configure dark mode on Arch Linux

echo "Setting up dark mode for Arch Linux..."

# Create config directories if they don't exist
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

# GTK 3 settings
echo "Configuring GTK 3..."
cat >~/.config/gtk-3.0/settings.ini <<'EOF'
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Sans 10
gtk-cursor-theme-name=Adwaita
EOF

# GTK 4 settings
echo "Configuring GTK 4..."
cat >~/.config/gtk-4.0/settings.ini <<'EOF'
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Sans 10
gtk-cursor-theme-name=Adwaita
EOF

# GTK 2 settings
echo "Configuring GTK 2..."
cat >~/.gtkrc-2.0 <<'EOF'
gtk-theme-name="Adwaita-dark"
gtk-icon-theme-name="Adwaita"
gtk-font-name="Sans 10"
gtk-cursor-theme-name="Adwaita"
EOF

# Qt settings (if using Qt apps)
echo "Configuring Qt..."
mkdir -p ~/.config/qt5ct
cat >~/.config/qt5ct/qt5ct.conf <<'EOF'
[Appearance]
color_scheme_path=/usr/share/qt5ct/colors/darker.conf
custom_palette=true
style=Fusion
EOF

# Set environment variables
echo "Setting environment variables..."
ENV_FILE=~/.config/environment.d/dark-mode.conf
mkdir -p ~/.config/environment.d
cat >$ENV_FILE <<'EOF'
GTK_THEME=Adwaita-dark
QT_QPA_PLATFORMTHEME=qt5ct
EOF

# Also add to shell profile for compatibility
if [ -f ~/.bashrc ]; then
    if ! grep -q "GTK_THEME=Adwaita-dark" ~/.bashrc; then
        echo "" >>~/.bashrc
        echo "# Dark mode settings" >>~/.bashrc
        echo "export GTK_THEME=Adwaita-dark" >>~/.bashrc
        echo "export QT_QPA_PLATFORMTHEME=qt5ct" >>~/.bashrc
    fi
fi

if [ -f ~/.zshrc ]; then
    if ! grep -q "GTK_THEME=Adwaita-dark" ~/.zshrc; then
        echo "" >>~/.zshrc
        echo "# Dark mode settings" >>~/.zshrc
        echo "export GTK_THEME=Adwaita-dark" >>~/.zshrc
        echo "export QT_QPA_PLATFORMTHEME=qt5ct" >>~/.zshrc
    fi
fi

echo ""
echo "✓ Dark mode configuration complete!"
echo ""
