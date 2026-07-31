#!/bin/sh

set -eu

TITLE=""
SLUG=""
DATE=""

usage() {
	echo "Usage: npm run new-post \"Title\" [slug] [YYYY-MM-DD]"
	exit 1
}

is_date() {
	case "$1" in
		[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;;
		*) return 1 ;;
	esac
}

for arg in "$@"; do
	if [ -z "$TITLE" ]; then
		TITLE=$arg
	elif [ -z "$SLUG" ]; then
		if is_date "$arg"; then
			DATE=$arg
		else
			SLUG=$arg
		fi
	elif [ -z "$DATE" ]; then
		if is_date "$arg"; then
			DATE=$arg
		else
			usage
		fi
	else
		usage
	fi
done

if [ -z "$TITLE" ]; then
	usage
fi

if [ -z "$DATE" ]; then
	DATE=$(date '+%Y-%m-%d')
fi

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
