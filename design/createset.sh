#!/bin/bash

mkdir -p AppIcon.appiconset

while read -r file size; do
    sips -z "$size" "$size" Logo.png \
        --out "AppIcon.appiconset/$file" >/dev/null
done <<EOF
Icon-40.png 40
Icon-60.png 60
Icon-58.png 58
Icon-87.png 87
Icon-76.png 76
Icon-114.png 114
Icon-80.png 80
Icon-120.png 120
Icon-120-1.png 120
Icon-180.png 180
Icon-128.png 128
Icon-192.png 192
Icon-136.png 136
Icon-152.png 152
Icon-167.png 167
EOF

cp Logo.png AppIcon.appiconset/Logo.png
