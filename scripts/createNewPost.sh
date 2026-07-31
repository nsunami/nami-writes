#!/bin/sh

set -eu

TITLE=""
SLUG=""
DATE=""

usage() {
	echo "Usage: npm run new-post \"Title\" [slug] [-d|--date YYYY-MM-DD]"
	exit 1
}

if [ $# -lt 1 ]; then
	usage
fi

while [ $# -gt 0 ]; do
	case "$1" in
		-d|--date)
			if [ $# -lt 2 ]; then
				usage
			fi
			DATE=$2
			shift 2
			;;
		-*)
			usage
			;;
		*)
			if [ -z "$TITLE" ]; then
				TITLE=$1
			elif [ -z "$SLUG" ]; then
				SLUG=$1
			else
				usage
			fi
			shift
			;;
	esac
done

if [ -z "$TITLE" ]; then
	usage
fi

if [ -z "$DATE" ]; then
	DATE=$(date '+%Y-%m-%d')
fi

case "$DATE" in
	[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;;
	*) echo "Invalid date: $DATE (expected YYYY-MM-DD)" >&2 && usage ;;
esac

# Generate a random 8-character hex string (works on macOS & Linux)
PERMALINK=$(openssl rand -hex 4)

DIR="./content/blog/$DATE"

if [ -n "$SLUG" ]; then
	FILE="$DIR/$DATE-$SLUG.md"
else
	FILE="$DIR/$DATE.md"
fi

if [ -e "$FILE" ]; then
	echo "Post already exists: $FILE"
	exit 1
fi

mkdir -p "$DIR"

cat << EOF > "$FILE"
---
title: $TITLE
description:
permalink: /$PERMALINK/
date: $DATE
tags: [tag]
---

EOF

echo "Created $FILE"

if [ -t 0 ]; then
	"${EDITOR:-vi}" "$FILE"
fi
