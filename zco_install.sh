#!/bin/bash

DESTINATION="${HOME}/.conkycolors"
ZCO_SH="$DESTINATION/zco.sh"
Y=500
X=520
STARTUP_DELAY=1

mkdir -p "$DESTINATION"

cat > "$ZCO_SH" <<EOF
#!/bin/bash
# AUTOMATICALLY GENERATED BY zco_install.sh
sleep "${STARTUP_DELAY}"
Y="${Y}"
X="${X}"
EOF
chmod +x "$ZCO_SH"

# installation helper for all scripts
do_script(){
  name="$1"
  xoffset="$2"
  # check if the file exists
  test ! -f "$name" && echo "can't find file: ${name}, aborting!" && exit 0
  # get the width of this element
  width=$(head -n1 "$name" | grep -oP "[0-9]+")
  # install script with template
  cp zco_template "$DESTINATION/$name"
  cat "$name" >> "$DESTINATION/$name"
  # update runner
  echo 'conky -d -y $Y -x '$xoffset' -c "'$name'"' >> "$ZCO_SH"
  if test -n "$width"; then
    echo 'X=$((X+'$width'))' >> "$ZCO_SH"
  fi
}

# install the background and adjust size
do_script background 0
sed -i "s/WIDTH/$WIDTH/" "$DESTINATION/background"

# install conky scripts
# for i in ctime cpower cnetwork cweather cmoon; do
for i in ctime cpower cnetwork cweather; do
  do_script $i '$X'
done

# install additional files
for i in pngs weatherhelper scripts; do
  cp -r "$i" "$DESTINATION"/.
done
