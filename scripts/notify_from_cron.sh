#!/bin/bash

set -euo pipefail

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export DBUS_SESSION_BUS_ADDRESS

notify-send -t 0 "$1"
