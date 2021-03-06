{-# LANGUAGE OverloadedStrings #-}
module Themes
  ( defaultThemeName
  , themes
  , attrNameForTokenType

  -- * Attribute names
  , timeAttr
  , channelHeaderAttr
  , channelListHeaderAttr
  , currentChannelNameAttr
  , unreadChannelAttr
  , mentionsChannelAttr
  , urlAttr
  , codeAttr
  , emailAttr
  , emojiAttr
  , channelNameAttr
  , clientMessageAttr
  , clientHeaderAttr
  , clientEmphAttr
  , clientStrongAttr
  , dateTransitionAttr
  , newMessageTransitionAttr
  , errorMessageAttr
  , helpAttr
  , helpEmphAttr
  , channelSelectPromptAttr
  , channelSelectMatchAttr
  , completionAlternativeListAttr
  , completionAlternativeCurrentAttr
  , dialogAttr
  , dialogEmphAttr
  , recentMarkerAttr
  , replyParentAttr
  , loadMoreAttr
  , urlListSelectedAttr
  , messageSelectAttr
  , messageSelectStatusAttr
  , misspellingAttr

  -- * Username formatting
  , colorUsername
  , attrForUsername
  ) where

import Prelude ()
import Prelude.Compat

import Data.Hashable (hash)
import Data.Monoid ((<>))
import Graphics.Vty
import Brick
import Brick.Widgets.List
import qualified Data.Text as T
import qualified Skylighting as Sky

import Types (userSigil)

defaultThemeName :: T.Text
defaultThemeName = darkColorThemeName

helpAttr :: AttrName
helpAttr = "help"

helpEmphAttr :: AttrName
helpEmphAttr = "helpEmphasis"

recentMarkerAttr :: AttrName
recentMarkerAttr = "recentMarker"

replyParentAttr :: AttrName
replyParentAttr = "replyParent"

loadMoreAttr :: AttrName
loadMoreAttr = "loadMoreMessages"

urlListSelectedAttr :: AttrName
urlListSelectedAttr = "urlListSelectedAttr"

messageSelectAttr :: AttrName
messageSelectAttr = "messageSelectAttr"

dialogAttr :: AttrName
dialogAttr = "dialog"

dialogEmphAttr :: AttrName
dialogEmphAttr = "dialogEmphasis"

channelSelectMatchAttr :: AttrName
channelSelectMatchAttr = "channelSelectMatch"

channelSelectPromptAttr :: AttrName
channelSelectPromptAttr = "channelSelectPrompt"

completionAlternativeListAttr :: AttrName
completionAlternativeListAttr = "completionAlternativeList"

completionAlternativeCurrentAttr :: AttrName
completionAlternativeCurrentAttr = "completionAlternativeCurrent"

darkColorThemeName :: T.Text
darkColorThemeName = "builtin:dark"

lightColorThemeName :: T.Text
lightColorThemeName = "builtin:light"

timeAttr :: AttrName
timeAttr = "time"

channelHeaderAttr :: AttrName
channelHeaderAttr = "channelHeader"

channelListHeaderAttr :: AttrName
channelListHeaderAttr = "channelListHeader"

currentChannelNameAttr :: AttrName
currentChannelNameAttr = "currentChannelName"

channelNameAttr :: AttrName
channelNameAttr = "channelNameAttr"

unreadChannelAttr :: AttrName
unreadChannelAttr = "unreadChannel"

mentionsChannelAttr :: AttrName
mentionsChannelAttr = "mentionsChannel"

dateTransitionAttr :: AttrName
dateTransitionAttr = "dateTransition"

newMessageTransitionAttr :: AttrName
newMessageTransitionAttr = "newMessageTransition"

urlAttr :: AttrName
urlAttr = "url"

codeAttr :: AttrName
codeAttr = "code"

emailAttr :: AttrName
emailAttr = "email"

emojiAttr :: AttrName
emojiAttr = "emoji"

clientMessageAttr :: AttrName
clientMessageAttr = "clientMessage"

clientHeaderAttr :: AttrName
clientHeaderAttr = "clientHeader"

clientEmphAttr :: AttrName
clientEmphAttr = "clientEmph"

clientStrongAttr :: AttrName
clientStrongAttr = "clientStrong"

errorMessageAttr :: AttrName
errorMessageAttr = "errorMessage"

misspellingAttr :: AttrName
misspellingAttr = "misspelling"

messageSelectStatusAttr :: AttrName
messageSelectStatusAttr = "messageSelectStatus"

themes :: [(T.Text, AttrMap)]
themes =
    [ (darkColorThemeName,      darkColorTheme)
    , (lightColorThemeName,     lightColorTheme)
    ]

lightColorTheme :: AttrMap
lightColorTheme =
  let sty = Sky.kate
  in attrMap (black `on` white) $
     [ (timeAttr,                         fg black)
     , (channelHeaderAttr,                fg black `withStyle` underline)
     , (channelListHeaderAttr,            fg cyan)
     , (currentChannelNameAttr,           black `on` yellow `withStyle` bold)
     , (unreadChannelAttr,                black `on` cyan   `withStyle` bold)
     , (mentionsChannelAttr,              black `on` red    `withStyle` bold)
     , (urlAttr,                          fg brightYellow)
     , (emailAttr,                        fg yellow)
     , (codeAttr,                         fg magenta)
     , (emojiAttr,                        fg yellow)
     , (channelNameAttr,                  fg blue)
     , (clientMessageAttr,                fg black)
     , (clientEmphAttr,                   fg black `withStyle` bold)
     , (clientStrongAttr,                 fg black `withStyle` bold `withStyle` underline)
     , (clientHeaderAttr,                 fg red `withStyle` bold)
     , (dateTransitionAttr,               fg green)
     , (newMessageTransitionAttr,         black `on` yellow)
     , (errorMessageAttr,                 fg red)
     , (helpAttr,                         black `on` cyan)
     , (helpEmphAttr,                     fg white)
     , (channelSelectMatchAttr,           black `on` magenta)
     , (channelSelectPromptAttr,          fg black)
     , (completionAlternativeListAttr,    white `on` blue)
     , (completionAlternativeCurrentAttr, black `on` yellow)
     , (dialogAttr,                       black `on` cyan)
     , (dialogEmphAttr,                   fg white)
     , (listSelectedFocusedAttr,          black `on` yellow)
     , (recentMarkerAttr,                 fg black `withStyle` bold)
     , (loadMoreAttr,                     black `on` cyan)
     , (urlListSelectedAttr,              black `on` yellow)
     , (messageSelectAttr,                black `on` yellow)
     , (messageSelectStatusAttr,          fg black)
     , (misspellingAttr,                  fg red `withStyle` underline)
     ] <>
     ((\(i, a) -> (usernameAttr i, a)) <$> zip [0..] usernameColors) <>
     (themeEntriesForStyle sty)

darkAttrs :: [(AttrName, Attr)]
darkAttrs =
  let sty = Sky.espresso
  in [ (timeAttr,                         fg white)
     , (channelHeaderAttr,                fg white `withStyle` underline)
     , (channelListHeaderAttr,            fg cyan)
     , (currentChannelNameAttr,           black `on` yellow `withStyle` bold)
     , (unreadChannelAttr,                black `on` cyan   `withStyle` bold)
     , (mentionsChannelAttr,              black `on` brightMagenta `withStyle` bold)
     , (urlAttr,                          fg yellow)
     , (emailAttr,                        fg yellow)
     , (codeAttr,                         fg magenta)
     , (emojiAttr,                        fg yellow)
     , (channelNameAttr,                  fg cyan)
     , (clientMessageAttr,                fg white)
     , (clientEmphAttr,                   fg white `withStyle` bold)
     , (clientStrongAttr,                 fg white `withStyle` bold `withStyle` underline)
     , (clientHeaderAttr,                 fg red `withStyle` bold)
     , (dateTransitionAttr,               fg green)
     , (newMessageTransitionAttr,         fg yellow `withStyle` bold)
     , (errorMessageAttr,                 fg red)
     , (helpAttr,                         black `on` cyan)
     , (helpEmphAttr,                     fg white)
     , (channelSelectMatchAttr,           black `on` magenta)
     , (channelSelectPromptAttr,          fg white)
     , (completionAlternativeListAttr,    white `on` blue)
     , (completionAlternativeCurrentAttr, black `on` yellow)
     , (dialogAttr,                       black `on` cyan)
     , (dialogEmphAttr,                   fg white)
     , (listSelectedFocusedAttr,          black `on` yellow)
     , (recentMarkerAttr,                 fg yellow `withStyle` bold)
     , (loadMoreAttr,                     black `on` cyan)
     , (urlListSelectedAttr,              black `on` yellow)
     , (messageSelectAttr,                black `on` yellow)
     , (messageSelectStatusAttr,          fg white)
     , (misspellingAttr,                  fg red `withStyle` underline)
     ] <>
     ((\(i, a) -> (usernameAttr i, a)) <$> zip [0..] usernameColors) <>
     (themeEntriesForStyle sty)

darkColorTheme :: AttrMap
darkColorTheme = attrMap defAttr darkAttrs

usernameAttr :: Int -> AttrName
usernameAttr i = "username" <> (attrName $ show i)

colorUsername :: T.Text -> Widget a
colorUsername s = withDefAttr (attrForUsername s) $ txt s

attrForUsername :: T.Text -> AttrName
attrForUsername s
    | (T.singleton userSigil) `T.isPrefixOf` s ||
      "+" `T.isPrefixOf` s ||
      "-" `T.isPrefixOf` s ||
      " " `T.isPrefixOf` s
      = usernameAttr $ hash (T.tail s) `mod` (length usernameColors)
    | otherwise = usernameAttr $ hash s `mod` (length usernameColors)

usernameColors :: [Attr]
usernameColors =
    [ fg red
    , fg green
    , fg yellow
    , fg blue
    , fg magenta
    , fg cyan
    , fg brightRed
    , fg brightGreen
    , fg brightYellow
    , fg brightBlue
    , fg brightMagenta
    , fg brightCyan
    ]

-- Functions for dealing with Skylighting styles

baseHighlightedCodeBlockAttr :: AttrName
baseHighlightedCodeBlockAttr = "highlightedCodeBlock"

attrNameForTokenType :: Sky.TokenType -> AttrName
attrNameForTokenType ty =
    baseHighlightedCodeBlockAttr <> (attrName $ show ty)

themeEntriesForStyle :: Sky.Style -> [(AttrName, Attr)]
themeEntriesForStyle sty =
    mkTokenTypeEntry <$> Sky.tokenStyles sty

baseAttrFromPair :: (Maybe Sky.Color, Maybe Sky.Color) -> Attr
baseAttrFromPair (mf, mb) =
    case (mf, mb) of
        (Nothing, Nothing) -> defAttr
        (Just f, Nothing)  -> fg (tokenColorToVtyColor f)
        (Nothing, Just b)  -> bg (tokenColorToVtyColor b)
        (Just f, Just b)   -> (tokenColorToVtyColor f) `on`
                              (tokenColorToVtyColor b)

tokenColorToVtyColor :: Sky.Color -> Color
tokenColorToVtyColor (Sky.RGB r g b) = rgbColor r g b

mkTokenTypeEntry :: (Sky.TokenType, Sky.TokenStyle) -> (AttrName, Attr)
mkTokenTypeEntry (ty, tSty) =
    let a = setStyle baseAttr
        baseAttr = baseAttrFromPair (Sky.tokenColor tSty, Sky.tokenBackground tSty)
        setStyle =
            if Sky.tokenBold tSty then flip withStyle bold else id .
            if Sky.tokenItalic tSty then flip withStyle standout else id .
            if Sky.tokenUnderline tSty then flip withStyle underline else id

    in (attrNameForTokenType ty, a)
