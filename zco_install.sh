#!/bin/bash

DESTINATION="${HOME}/.conkycolors"
ZCO_SH="$DESTINATION/zco.sh"
Y=550
X=490

mkdir -p "$DESTINATION"

cat > "$ZCO_SH" <<EOF
#!/bin/bash
# AUTOMATICALLY GENERATED BY zco_install.sh
Y="${Y}"
X="${X}"
EOF
chmod +x "$ZCO_SH"

do_script(){
  name="$1"
  x="$2"
  # check if the file exists
  test ! -f "$name" && echo "can't find file: ${name}, aborting!" && exit 0
  # get the width of this element
  width=$(head -n1 "$name" | grep -oP "[0-9]+")
  # install script with template
  cp zco_template "$DESTINATION/$name"
  cat "$name" >> "$DESTINATION/$name"
  # update runner
  echo 'conky -d -y $Y -x '$x' -c "'$name'"' >> "$ZCO_SH"
  if test -n "$width"; then
    echo 'X=$((X+'$width'))' >> "$ZCO_SH"
  fi
}

do_script background 0
# install conky scripts
for i in ctime cpower cnetwork cweather cmoon; do
  do_script $i '$X'
done

# install additional files
for i in pngs weatherhelper; do
  cp -r "$i" "$DESTINATION"/.
done