{-# LANGUAGE NoMonomorphismRestriction #-}

import XMonad
import Data.Monoid
import System.Exit
import Data.List
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import           XMonad.Util.EZConfig
import           XMonad.Hooks.DynamicLog
import           XMonad.Util.Loggers
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run(spawnPipe)
import           XMonad.Actions.GroupNavigation
import           System.IO
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.SetWMName
import           XMonad.Actions.CopyWindow
import           XMonad.Hooks.FadeInactive
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Tabbed
import           XMonad.Layout.LayoutCombinators hiding ((|||))
import           XMonad.Layout.ComboP
import           XMonad.Layout.Grid
import           XMonad.Layout.TwoPane
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.Decoration
import           XMonad.Layout.Simplest
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Scratchpad
import           XMonad.Layout.IM
import           XMonad.Layout.Reflect

myTerminal          = "/usr/bin/urxvtc"
myModMask           = mod4Mask
myBorderWidth       = 1
myFocusFollowsMouse = False
myFont              = "xft:DejaVu Sans Mono:regular:size = 10"

------------------------------
-- WORKSPACES
------------------------------

------------------------------
-- SCRATCHPADS
------------------------------

myScratchpads = let 
  full = customFloating $ W.RationalRect 0.05 0.05 0.9 0.9
  top = customFloating $ W.RationalRect 0.025 0.05 0.95 0.45
  bottom = customFloating $ W.RationalRect 0.025 0.50 0.95 0.45
  in [
    NS "Mail" 
       "chromium --app=https://mail.google.com"
       (appName =? "mail.google.com") full
  , NS "Calendar" 
       "chromium --app=https://calendar.google.com"
       (appName =? "calendar.google.com") full
  , NS "Bookmarks" 
       "chromium --app=http://bookmarks.google.com"
       (appName =? "bookmarks.google.com") full
  , NS "Drive" 
       "chromium --app=https://drive.google.com"
       (appName =? "drive.google.com") full
  , NS "Transmission" 
       "transmission-gtk"
       (appName =? "transmission-gtk") full
  , NS "Studentportalen" 
       "chromium --app=studentportal.chalmers.se"
       (appName =? "studentportal.chalmers.se") full
  , NS "TimeEdit: Grupprum" 
       "chromium --app=https://web.timeedit.se/chalmers_se/db1/b1/"
       (appName =? "web.timeedit.se__chalmers_se_db1_b1") full
  , NS "TimeEdit: Schema" 
       "chromium --app=https://web.timeedit.se/chalmers_se/db1/public/r.html?sid=3&h=t"
       (appName =? "web.timeedit.se__chalmers_se_db1_public_r.html") full
  , NS "CTK" 
       "chromium --app=http://intranet.ctk.se"
       (appName =? "intranet.ctk.se") full
  , NS "Volume" 
       "urxvtc -name volume -e alsamixer" 
       (appName =? "volume") full
  , NS "Network"
       "urxvtc -name Network -e wicd-curses" 
       (appName =? "Network") full
  , NS "BottomTerminal"
       "urxvtc -name BottomTerminal" 
       (appName =? "BottomTerminal") bottom
  , NS "TopTerminal"
       "urxvtc -name TopTerminal" 
       (appName =? "TopTerminal") top
  ]

myWorkspaces = map show [1..9] ++ map (:[]) ['a'..'z']

myStartupWorkspace = "b"

------------------------------
-- KEYBINDS
------------------------------

myKeys = myModKeys ++ myModShiftKeys ++ myScratchpadKeys ++ mySpecialKeys 
          ++ mySwitchWorkspaceKeys ++ mySwitchScreenKeys where 
  myModKeys =
    let binds =
          [ (xK_r, refresh)
          , (xK_l, sendMessage Expand)
          , (xK_comma, sendMessage $ IncMasterN 1)
          , (xK_a, spawn "amixer -q set Master 10%-")
          , (xK_o, spawn "amixer -q set Master toggle")
          , (xK_e, spawn "amixer -q set Master 10%+")
          , (xK_u, sendMessage ToggleStruts)
          , (xK_h, sendMessage Shrink)
          , (xK_t, withFocused $ windows . W.sink)
          , (xK_n, spawn myTerminal)
          , (xK_s, namedScratchpadAction myScratchpads "BottomTerminal")
          , (xK_minus, spawn "mydmenu")
          , (xK_period, sendMessage $ IncMasterN $ -1)
          , (xK_q, spawn "xmonad --recompile; xmonad --restart")
          , (xK_j, windows W.focusDown)
          , (xK_k, windows W.focusUp)
          , (xK_Return, windows W.swapMaster)
          , (xK_space, sendMessage NextLayout)
          ]
    in [((myModMask, key), action) | (key, action) <- binds]
  myModShiftKeys =
    let binds =
          [ (xK_c, kill)
          , (xK_q, io (exitWith ExitSuccess))
          , (xK_j, windows W.swapDown)
          , (xK_k, windows W.swapUp)
          , (xK_m, windows W.focusMaster)
          , (xK_s, namedScratchpadAction myScratchpads "TopTerminal")
          ]
    in [((myModMask .|. shiftMask, key), action) | (key, action) <- binds]
  myScratchpadKeys =
    let binds =
          [ (xK_m, "Mail")
          , (xK_c, "Calendar")
          , (xK_b, "Bookmarks")
          , (xK_t, "CTK")
          , (xK_r, "Transmission")
          , (xK_v, "Volume")
          , (xK_n, "Network")
          , (xK_s, "Studentportalen")
          , (xK_g, "TimeEdit: Grupprum")
          , (xK_e, "TimeEdit: Schema")
          , (xK_d, "Drive")
          ]
    in [((myModMask .|. mod1Mask, key), namedScratchpadAction myScratchpads scratchpad) | (key, scratchpad) <- binds]
  mySpecialKeys = [
      ((0, xK_Print ), spawn "scrot")
    , ((controlMask, xK_Print ), spawn "sleep 0.2; scrot -s")
    ]
  mySwitchWorkspaceKeys = [
    ((m .|. myModMask .|. mod5Mask, k), windows $ f i)
      | (i, k) <- zip myWorkspaces ([xK_1..xK_9] ++ [xK_a..xK_z])
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  mySwitchScreenKeys = [
    ((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_v, xK_z] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------
-- LAYOUTS
------------------------------

myTiled = smartBorders $ Tall nmaster delta ratio
  where nmaster = 1
        delta = 3 / 100
        ratio = 1 / 2

myTabbed = tabbed shrinkText tabTheme

myLayout = avoidStruts $ smartBorders $ 
            myTabbed 
            ||| myTiled 
            ||| Mirror myTiled 
            ||| Full

------------------------------
-- THEME
------------------------------

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

myNormalBorderColor = base02
myFocusedBorderColor = base1

myTheme :: Theme
myTheme = defaultTheme { activeColor = base03
                       , activeBorderColor = base03
                       , inactiveColor = base02
                       , inactiveBorderColor = base02
                       , activeTextColor = base1
                       , inactiveTextColor = base00
                       , fontName = "xft:DejaVu Sans Mono:regular:size=10"
                       , decoHeight = 24 }

baseTheme :: Theme
baseTheme = defaultTheme
    { activeColor           = base03
    , activeBorderColor     = base03
    , activeTextColor       = base01 -- blue also good
    , inactiveBorderColor   = base02
    , inactiveColor         = base02
    , inactiveTextColor     = base01
    , urgentColor           = yellow
    , urgentBorderColor     = yellow
    , urgentTextColor       = base02
    , fontName              = myFont
    , decoHeight            = 22
    }

tabTheme :: Theme
tabTheme = baseTheme
    { -- base00, base01, blue all good activeColors
      activeColor           = base03
    , activeBorderColor     = base03
    , activeTextColor       = base00
    }

------------------------------
-- MANAGEHOOKS
------------------------------

myManageHook = namedScratchpadManageHook myScratchpads
               <+> manageDocks

myHandleEventHook = docksEventHook
                    <+> handleEventHook defaultConfig
        
myStartupHook = do
  setWMName "LG3D"
  windows $ W.greedyView myStartupWorkspace

myPP = defaultPP
    { ppCurrent             = xmobarColor base02 blue . wrap " " " "
    , ppTitle               = xmobarColor base00 "" . shorten 200
    , ppVisible             = wrap "(" ")"
    , ppUrgent              = xmobarColor base02 yellow . wrap " " " "
    , ppHidden              = id
    , ppHiddenNoWindows     = const ""
    , ppSep                 = " : "
    , ppWsSep               = " "
    , ppLayout              = const ""
    , ppOrder               = id
    , ppOutput              = putStrLn
    , ppSort                = fmap 
                              (namedScratchpadFilterOutWorkspace.)
                              (ppSort defaultPP)
    , ppExtras              = []
    }

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig {
    terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , borderWidth        = myBorderWidth
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask            = myModMask
  , workspaces         = myWorkspaces
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , startupHook        = myStartupHook
  , handleEventHook    = myHandleEventHook
  , logHook            = do
      historyHook
      fadeInactiveLogHook 0xbbbbbbbb
      copies <- wsContainingCopies
      let check ws | ws `elem` copies = xmobarColor yellow base02 $ ws
                   | otherwise = ws
      dynamicLogWithPP myPP 
        { ppHidden = check
        , ppOutput = hPutStrLn xmproc
        }
} `additionalKeys` myKeys
