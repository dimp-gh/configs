import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks  
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.UrgencyHook
import qualified Data.Map as M
import XMonad.Util.Run
import System.IO
import Graphics.X11.ExtraTypes.XF86


myWorkspaces    = [ "emacs"
                  , "web"
                  , "im"
                  ] ++ map show [4..9] ++ ["misc"]

background  	= "#2e323b"
foreground  	= "#ffffff"
active	    	= "#68A9AD"
inactive    	= "#d2d2d2"
nowindow    	= "#808080"
urgent          = "#FF6347"

myTerminal  	= "terminator"
myFont          = "Monaco-11"

myModMask 	= mod4Mask

myDmenu 	= "dmenu_run -fn '"++myFont++"' -nb '"++background++"' -nf '"++inactive++"' -sb '"++active++"' -sf '"++inactive++"'"

myStartMenu 	= "/home/dmand/.xmonad/start /home/dmand/.xmonad/apps"
myXmonadBar 	= "dzen2 -x '250' -y '0' -h '30' -w '1000' -ta 'l' -fg '"++foreground++"' -bg '"++background++"' -fn '"++myFont++"'"
myStatusBar 	= "conky -qc  /home/dmand/.xmonad/.conky_dzen | dzen2 -x '1250' -w '670' -h '30' -ta 'r' -bg '"++background++"' -fg '"++foreground++"' -y '0' -fn '"++myFont ++ "'"


myLogHook h = dynamicLogWithPP (defaultPP
  { ppCurrent		= dzenColor active background . pad
  , ppVisible		= dzenColor inactive background . pad
  , ppHidden		= dzenColor inactive background . pad
  , ppTitle             = dzenColor inactive background . pad
  , ppHiddenNoWindows	= dzenColor nowindow background . pad
  , ppWsSep		= ""
  , ppSep		= ""
  , ppLayout		= const ""
  , ppOrder	        = \(ws:l:t:_) -> [ws, t, l]
  , ppOutput	        = hPutStrLn h
  , ppUrgent            = dzenColor urgent background . pad
  } )

setXstuff = spawn "sh /home/dmand/.xstuffrc"
setWallpaper = spawn "feh --bg-fill /home/dmand/.xmonad/gybe.jpg"

main = do
  setWallpaper
  setXstuff  
  
  dzenMenu	<- spawnPipe myStartMenu
  dzenXmonadBar <- spawnPipe myXmonadBar
  dzenStatusBar	<- spawnPipe myStatusBar

  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
       { workspaces = myWorkspaces
       , terminal = myTerminal
       , focusFollowsMouse = True
       , modMask = myModMask              
       , keys = \c -> mykeys c `M.union` keys defaultConfig c
       , manageHook = manageSpawn <+> manageDocks <+> manageHook defaultConfig
       , layoutHook = avoidStruts $ layoutHook defaultConfig
       , focusedBorderColor = urgent
       , borderWidth = 2
       , logHook = myLogHook dzenXmonadBar
       }
  where
    mykeys (XConfig {XMonad.modMask = modm}) = M.fromList $
         [ ((modm,  xK_Down),                 nextWS)
         , ((modm,  xK_Up),                   prevWS)
         , ((modm .|. controlMask, xK_Down),  shiftToNext)
         , ((modm .|. controlMask, xK_Up),    shiftToPrev)
         , ((modm,               xK_z),       toggleWS)
         , ((mod1Mask, xK_a),                 spawn myDmenu)
         , ((modm, xK_a),                     spawn myDmenu)
         , ((modm, xK_y),                     focusUrgent )
         , ((shiftMask .|. controlMask, xK_bracketleft), spawn "volume down")
         , ((shiftMask .|. controlMask, xK_bracketright), spawn "volume up")

         , ((0, xF86XK_AudioLowerVolume),     spawn "volume down")
         , ((0, xF86XK_AudioRaiseVolume),     spawn "volume up")
         , ((0, xF86XK_AudioMute),            spawn "volume mute")

         , ((0, xF86XK_KbdBrightnessUp),     spawn "xbacklight -inc 5")
         , ((0, xF86XK_KbdBrightnessDown),   spawn "xbacklight -dec 5")

         , ((controlMask .|. shiftMask .|. modm, xK_a), spawn "/usr/bin/gnome-screenshot -a")
	 , ((modm, xK_o), spawnOn "emacs" "emacs")
         ]

  --keys to unset: M-S-RET, M-w


