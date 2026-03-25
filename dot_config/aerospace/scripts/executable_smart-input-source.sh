#!/bin/zsh

# 输入法智能切换
# Ghostty -> ABC
# QQ      -> 中文

MACISM="$(command -v macism)"
[[ -z "$MACISM" ]] && exit 0

front_app=$(/usr/bin/osascript -e 'tell application "System Events" to get bundle identifier of first application process whose frontmost is true')

case "$front_app" in
"com.mitchellh.ghostty")
	"$MACISM" com.apple.keylayout.ABC
	;;
"com.tencent.qq")
	"$MACISM" com.apple.inputmethod.SCIM.ITABC
	;;
esac
