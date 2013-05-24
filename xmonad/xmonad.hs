import XMonad
--import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks  
import XMonad.Actions.CycleWS
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
  xmproc <- spawnPipe "/usr/bin/xmobar /home/dmitry/.xmobarrc"
  --spawn "xrandr -s 1366x768"
  --terminator <- spawnPipe "terminator"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
       { workspaces = myWorkspaces
       , terminal = "terminator"
       , focusFollowsMouse = True
       , modMask = mod4Mask              
       , keys = \c -> mykeys c `M.union` keys defaultConfig c
       , manageHook = manageDocks <+> manageHook defaultConfig
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
         , ((mod1Mask, xK_a),                 spawn "dmenu_run")
         , ((modm, xK_a),                     spawn "dmenu_run")
         , ((modm, xK_y),                     focusUrgent )
         , ((modm, xK_y),                     spawn "terminator")
         , ((shiftMask .|. controlMask, xK_bracketleft),       spawn "amixer -c 1 sset Master 5%-")
         , ((shiftMask .|. controlMask, xK_bracketright),      spawn "amixer -c 1 sset Master 5%+")
         --, ((0, xF86XK_Display),      spawn "xbacklight -inc 10")
         --, ((0, xF86XK_MonBrightnessDown),    spawn "xbacklight -dec 10")
           --YUNOWORKING?, ((modm .|. shiftMask, xK_s), spawn "/usr/bin/gnome-screenshot -a")
         ]

  --keys to unset: M-S-RET, M-w


