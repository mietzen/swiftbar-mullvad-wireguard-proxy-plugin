#!/usr/bin/env bash

# <xbar.title>Mulvad Proxy Setter</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Nils Stein</xbar.author>
# <xbar.author.github>mietzen</xbar.author.github>
# <xbar.desc>Menu to switch macOS system SOCKS5 proxy to any Mullvad SOCKS5 proxy</xbar.desc>
# <xbar.dependencies>python</xbar.dependencies>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! -d "${SCRIPT_DIR}" ]; then
    mkdir -p "${SCRIPT_DIR}/assets"
    BASE_URL='https://raw.githubusercontent.com/mietzen/xbar-mullvad-wireguard-proxy-plugin/main'
    wget -qO "${SCRIPT_DIR}/mullvad-wireguard-proxy.py" "$BASE_URL/mullvad-wireguard-proxy.py"
    wget -qO "${SCRIPT_DIR}/requierments" "$BASE_URL/requierments"
    wget -qO "${SCRIPT_DIR}/assets/mullvad_icon.png" "$BASE_URL/assets/mullvad_icon.png"
    if [ ! -f "$HOME/Library/LaunchAgents/app.swiftbar.update-mullvad-on-change.plist" ]; then
        wget -qO  "$HOME/Library/LaunchAgents/app.swiftbar.update-mullvad-on-change.plist" "$BASE_URL/app.swiftbar.update-mullvad-on-change.plist"
        launchctl load -w "$HOME/Library/LaunchAgents/app.swiftbar.update-mullvad-on-change.plist"
    fi
fi

if [ ! -d "${SCRIPT_DIR}/.venv" ]; then
    python3 -m venv "${SCRIPT_DIR}/.venv"
    "${SCRIPT_DIR}/.venv/bin/pip3" install -r "${SCRIPT_DIR}/requierments" -q
fi
"${SCRIPT_DIR}/.venv/bin/python3" "${SCRIPT_DIR}/mullvad-wireguard-proxy.py"
