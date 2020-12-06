-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then findme = cmd:sub(0, firstspace - 1) end
    awful.spawn.with_shell(string.format(
                               'pgrep -u $USER -x %s > /dev/null || (%s)',
                               findme, cmd), false)
end

-- Network Manager Applet
run_once("nm-applet")

-- Disable Bell
run_once("xset -b")

-- Mpd Cleanup
run_once([[
    ps aux | grep "mpc idleloop player" | grep -v grep | awk '{print $2}' | xargs kill
    ]])

-- For bitmap
run_once([[
    xset +fp /home/javacafe01/.local/share/fonts; xset fp rehash
]])

-- Bluetooth
run_once("blueman-applet")

-- For Dual Monitors
run_once(
    "if xrandr | grep DP-1-0; then xrandr --auto --output DP-1-0 --mode 1920x1080 --right-of eDP1; fi")

-- Compositor
run_once("picom --experimental-backend")

-- Polkit
run_once("/usr/lib/polkit-kde-authentication-agent-1 &")

return autostart

-- EOF ------------------------------------------------------------------------
