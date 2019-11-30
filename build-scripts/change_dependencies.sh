#!/bin/bash
DEBFILE="$1"
TMPDIR=$(mktemp -d /tmp/deb.XXXXXXXXXX)|| exit 1
OUTPUT=$(basename "$DEBFILE" .deb).modified.deb
rm -f $OUTPUT

if [[ -e "$OUTPUT" ]]; then
  echo "$OUTPUT exists."
  rm -r "$TMPDIR"
  exit 1
fi

dpkg-deb -x "$DEBFILE" "$TMPDIR"
dpkg-deb --control "$DEBFILE" "$TMPDIR"/DEBIAN

if [[ ! -e "$TMPDIR"/DEBIAN/control ]]; then
  echo DEBIAN/control not found.

  rm -r "$TMPDIR"
  exit 1
fi

CONTROL="$TMPDIR"/DEBIAN/control

MOD=$(stat -c "%y" "$CONTROL")
sed -i -e '/Depends/d' -e "$ d" "$CONTROL"
if [ ! -z "$2" ]; then
    echo "Depends: $2" >> "$CONTROL"
fi
echo "" >> "$CONTROL"

if [[ "$MOD" == $(stat -c "%y" "$CONTROL") ]]; then
  echo Not modified.
else
  dpkg -b "$TMPDIR" "$OUTPUT" > /dev/null
fi

rm -r "$TMPDIR"
cp $OUTPUT $DEBFILE
rm $OUTPUT
