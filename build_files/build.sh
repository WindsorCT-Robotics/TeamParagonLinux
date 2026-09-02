#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

#### Versions
WPILIB_DIR="/ctx/build_files/wpilib_context"
WPILIB_INSTALL_DIR="/usr/local/wpilib/2027"
GRADLE_CACHE_DIR="/usr/share/gradle/cache"
VSCODE_TEMP_DIR="/tmp/vscode-root"
VSCOODE_EXTENSIONS_DIR="/usr/share/code/extensions"
VSCODE_EXTENSIONS=(
    "MS-vsliveshare.vsliveshare"
    "vscjava.vscode-java-pack"
    "christian-kohler.path-intellisense"
    "EditorConfig.EditorConfig"
    "maxking.forgejo-vscode"
    "usernamehw.errorlens"
    "DavidAnson.vscode-markdownlint"
    "PKief.material-icon-theme"
)

# Install FRC and WPILib for robotics development

echo "=== Installing WPILib Extensions into System Layer ==="
mkdir -p ${WPILIB_INSTALL_DIR}
cd ${WPILIB_DIR}

echo "--- Installing JDK and Maven ---"

mv jdk ${WPILIB_INSTALL_DIR}/jdk
mv maven ${WPILIB_INSTALL_DIR}/maven

echo "--- Setting up environment variables for WPILib ---"

mkdir -p /etc/profile.d
cat << 'EOF' > /etc/profile.d/wpilib.sh
export JAVA_HOME="/usr/local/wpilib/2027/jdk"
export PATH="${JAVA_HOME}/bin:${PATH}"
export WPILIB_OFFLINE_MAVEN="/usr/local/wpilib/2027/maven"
EOF

# Source the profile to make the environment variables available in this script
source /etc/profile.d/wpilib.sh

echo "=== Installing other VSCode Extensions into System Layer ==="

for extension in "${VSCODE_EXTENSIONS[@]}"; do
    code --user-data-dir=${VSCODE_TEMP_DIR} --extensions-dir=${VSCOODE_EXTENSIONS_DIR} --install-extension ${extension}
done

# Vivaldi as default browser



# Install gh command line tool from the official GitHub repository

# Install GitHub Desktop

# Install Bitwarden password manager

# Install Discord Canary

# Create website shortcut for onshape

# Install Rider


# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
