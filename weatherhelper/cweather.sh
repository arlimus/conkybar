#!/bin/sh
get(){
  field="$1"
  ret="$(cat ~/.conkycolors/weatherhelper/info 2>/dev/null | grep '^'$field':' | sed 's/'$field': //')"
  if test -z "$ret"; then
    echo -n '??'
  else
    echo -n "$ret"
  fi
}
echo ''\
'${voffset 108}${goto 70}'$(get 'right_now_c')'°C'\
'${voffset 42}${goto 35}'$(get 'earlier_c')'°C'\
'${voffset 0}${goto 112}'$(get 'later_c')'°C'