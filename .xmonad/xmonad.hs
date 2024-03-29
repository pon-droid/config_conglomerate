import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Cross
import XMonad.Layout.Dwindle
import XMonad.Layout.ThreeColumns
import XMonad.Actions.NoBorders
import XMonad.Layout.Spacing
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Tabbed
import XMonad.Hooks.SetWMName

main :: IO ()
main = do
	xmproc <- spawnPipe "xmobar -x 0 /home/tgallaher/.xmobarrc"
	staloneproc <- spawnPipe "stalonetray"
	xmonad $ ewmhFullscreen $ ewmh $ docks myConfig
--        xmonad $ ewmh $ docks myConfig


myConfig = def
	{modMask      = mod3Mask
	,terminal     = "alacritty"
	,startupHook  = myStartupHook
	,layoutHook   = spacingWithEdge 10 $ myLayout
	,borderWidth  = 1
        ,manageHook   = manageSpawn <+> manageHook def
	}
	`additionalKeysP`
	[ ("M-S-l", spawn "xscreensaver-command --lock")
	, ("M-q"  , spawn "xmonad --recompile; killall xmobar; killall stalonetray; xmonad --restart")
	, ("M-S-f", 
	           sequence_[withFocused toggleBorder
	          ,toggleScreenSpacingEnabled
	          ,toggleWindowSpacingEnabled
	          ,sendMessage ToggleStruts
	          ,spawn "sh /home/tgallaher/.xmonad/stalone.sh"] )
	, ("M-p"  ,spawn "rofi -show drun &")
	, ("M-S-p",  spawn "rofi -show run &")

	]


myStartupHook = do
--	spawnOnce "setxkbmap -option ctrl:nocaps &"
--      spawnOnce "export XDG_DATA_DIRS='/home/tgallaher/.guix-profile/share:$XDG_DATA_DIRS' &"
	spawnOnce "xmodmap ~/.xmodmap &"
	spawnOnce "xsetroot -cursor_name left_ptr &"
	spawnOnce "nitrogen --restore &"
	spawnOnce "compton &"
	spawnOnce "biglybt &"
--	spawnOnce "deluge &"
	spawnOnce "xscreensaver -no-splash &"
        setWMName "LG3D"



myLayout = avoidStruts (threeCol ||| Spiral L CW 1.5 1.1 ||| tiled ||| Mirror tiled ||| Full)
  where
    threeCol = ThreeCol nmaster delta ratio

    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes
