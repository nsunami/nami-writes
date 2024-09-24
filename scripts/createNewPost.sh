#!/bin/sh

TITLE=$1
TODAY=$(date '+%Y-%m-%d')

# Generate random string
PERMALINK=$(md5 -qs $RANDOM | head -c 8)

mkdir ./content/blog/$TODAY


cat << EOF > ./content/blog/$TODAY/$TODAY.md
---
title: $TITLE
description:
permalink: /$PERMALINK/
date: $TODAY
tags: [tag]
---

EOF

