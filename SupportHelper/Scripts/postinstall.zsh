#!/bin/zsh

# Install SupportHelper LaunchDaemon
#
#
# Copyright 2022 Root3 B.V. All rights reserved.
#
# This script will create the SupportHelper LaunchDaemon and reload it when
# needed.
#
# THE SOFTWARE IS PROVIDED BY ROOT3 B.V. "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
# EVENT SHALL ROOT3 B.V. BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
# IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# LaunchDaemon label
launch_daemon="nl.root3.support.helper"

# CLI location
cli_location="/usr/local/bin/SupportHelper"

# Create the LaunchAgent
defaults write "/Library/LaunchDaemons/${launch_daemon}.plist" Label -string "${launch_daemon}"
defaults write "/Library/LaunchDaemons/${launch_daemon}.plist" ProgramArguments -array -string "${cli_location}"
# Keep the process alive
defaults write "/Library/LaunchDaemons/${launch_daemon}.plist" KeepAlive -boolean yes
# Run at every reboot
defaults write "/Library/LaunchDaemons/${launch_daemon}.plist" RunAtLoad -boolean yes
# Set permissions
chown root:wheel "/Library/LaunchDaemons/${launch_daemon}.plist"
chmod 644 "/Library/LaunchDaemons/${launch_daemon}.plist"

# Unload the LaunchDaemon
launchctl bootout system "/Library/LaunchDaemons/${launch_daemon}.plist" &> /dev/null
# Load the LaunchAgent
launchctl bootstrap system "/Library/LaunchDaemons/${launch_daemon}.plist"
