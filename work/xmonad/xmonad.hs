import XMonad
--import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks  
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.UrgencyHook
import qualified Data.Map as M
import XMonad.Util.Run
import System.IO
import Graphics.X11.ExtraTypes.XF86

myWorkspaces :: [String]
myWorkspaces = [ "1:emacs"
               , "2:web"
               , "3:im"
               ] ++ map show [4..9] ++ ["0:read"]

main :: IO ()
main = do
  -- background image
  feh <- spawnPipe "feh --bg-scale ~/Downloads/wallpaper-2552963.jpg"
  -- configuring x stuff (keyboard, cursor) 
  xstuff <- spawnPipe "/home/dmand/.xstuffrc"
  -- xmobar
  xmproc <- spawnPipe "/usr/bin/xmobar /home/dmand/.xmobarrc"

  -- autostarting apps
  -- TODO: use startupHook
  -- emacs <- spawnOn "1:emacs" "emacs"
  -- terminator <- spawnOn "1:emacs" "terminator"
  -- firefox <- spawnOn "2:web" "firefox"
  -- skype <- spawnOn "3:im" "skype"

  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
       { workspaces = myWorkspaces
       , terminal = "terminator"
       , focusFollowsMouse = True
       , modMask = mod1Mask              
       , keys = \c -> mykeys c `M.union` keys defaultConfig c
       , manageHook = manageSpawn <+> manageDocks <+> manageHook defaultConfig
       , layoutHook = avoidStruts $ layoutHook defaultConfig
       , focusedBorderColor = "#FF6347" -- #A22222
       , borderWidth = 2
       , logHook = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc  
           , ppTitle = xmobarColor "lightgrey" "" . shorten 75 -- #999999   
           , ppLayout = const ""
           , ppCurrent = xmobarColor "black" "#88BBBB" . wrap "[" "]"
           , ppUrgent = xmobarColor "black" "#C23232" . wrap "[" "]" --B22222 is also good
           }
       }
  where
    mykeys (XConfig {XMonad.modMask = modm}) = M.fromList $
         [ ((modm,  xK_Down),                 nextWS)
         , ((modm,  xK_Up),                   prevWS)
         , ((modm .|. controlMask, xK_Down),  shiftToNext)
         , ((modm .|. controlMask, xK_Up),    shiftToPrev)
         , ((modm,               xK_z),       toggleWS)
         , ((modm .|. shiftMask, xK_q),       spawn "gnome-session-quit --logout")
         , ((mod4Mask, xK_a),                 spawn "dmenu_run -fn 'Ubuntu Mono-11'")
         , ((modm, xK_a),                     spawn "dmenu_run -fn 'Ubuntu-Mono-11'")
         , ((modm, xK_y),                     focusUrgent )
         , ((shiftMask .|. controlMask, xK_bracketleft),       spawn "amixer -c 0 sset Master 5%-")
         , ((shiftMask .|. controlMask, xK_bracketright),      spawn "amixer -c 0 sset Master 5%+")
         , ((0, xF86XK_AudioLowerVolume),      spawn "amixer -c 0 sset Master 5%-")
         , ((0, xF86XK_AudioRaiseVolume),      spawn "amixer -c 0 sset Master 5%+")

         --, ((0, xF86XK_Display),      spawn "xbacklight -inc 10")
         --, ((0, xF86XK_MonBrightnessDown),    spawn "xbacklight -dec 10")
         --YUNOWORKING?, ((modm .|. shiftMask, xK_s), spawn "/usr/bin/gnome-screenshot -a")
	 , ((modm, xK_o), spawnOn "1:emacs" "emacs")
	 --, ((modm, xK_s), shellPromptHere defaultXPConfig)
         ]

  --keys to unset: M-S-RET, M-w


