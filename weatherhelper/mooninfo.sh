#!/bin/sh
TMP_PATH='/tmp'
OUT_PATH='/tmp'

wget --user-agent="Mozilla" http://static.die.net/moon/512.jpg -O "$TMP_PATH"/moon.jpeg
convert "$TMP_PATH"/moon.jpg moonmask.png -alpha Off -compose CopyOpacity -composite "$OUT_PATH"/moon.png

# get info on the moon
wget --user-agent="Mozilla" http://www.die.net/moon/ -O "$TMP_PATH"/moon.die.net.html
mooninfo=$(cat "$TMP_PATH"/moon.die.net.html |grep -Pzo "The\s*\n[^:]*" | tail -n1)

# split info into fields
name=$(echo $mooninfo| sed 's/,.*$//')
age=$(echo $mooninfo| grep -oP '[0-9]+([.][0-9]+)?(?=\s*day\s*old)')
percentage=$(echo $mooninfo| grep -oP '[0-9]+([.][0-9]+)?(?=%\s*lit)')

# save to file
echo -n > "$OUT_PATH"/moon.info
echo "name: $name" >> "$OUT_PATH"/moon.info
echo "age: $age" >> "$OUT_PATH"/moon.info
echo "percentage: $percentage" >> "$OUT_PATH"/moon.info