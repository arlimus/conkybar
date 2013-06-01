#!/bin/bash

CODE="$1"
#put your 10 day weather.com address here
BASEURL="http://www.weather.com/weather"
TODAY="$BASEURL/today/$CODE"
TENDAY="$BASEURL/tenday/$CODE"
ICONS="/usr/share/conkycolors/icons/Weather"
OUT="${HOME}/.conkycolors/weatherhelper/info"
ICON_DST="${HOME}/.conkycolors/weatherhelper/icons"

# prepare folders/files
mkdir -p "$ICON_DST"
echo -n > "$OUT"

# get the weather
wget --user-agent="Mozilla" "$TODAY" -O /tmp/weather.today.html

# get the current temperature
tmp_f=$( grep -oP '(?<=<span class="wx-value" itemprop="temperature-fahrenheit">)[0-9]+([.][0-9]+)?' /tmp/weather.today.html )
if test -n "$tmp_f"; then
  echo "right_now_f: $tmp_f" >> "$OUT"
  echo "right_now_c: $((($tmp_f-32)*5/9))" >> "$OUT"
else
  echo "right_now_f: ??" >> "$OUT"
  echo "right_now_c: ??" >> "$OUT"
fi

ICONS_TODAY="$(cat /tmp/weather.today.html | grep "wx-weather-icon" | tail -n3 | grep -oP "[0-9]+[.]png")"
cp "${ICONS}/$(echo ${ICONS_TODAY}| awk '{print $1}')" "$ICON_DST"/now.png
cp "${ICONS}/$(echo ${ICONS_TODAY}| awk '{print $2}')" "$ICON_DST"/earlier.png
cp "${ICONS}/$(echo ${ICONS_TODAY}| awk '{print $3}')" "$ICON_DST"/later.png