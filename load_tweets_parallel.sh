#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | parallel ./load_denormalized.sh
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | parallel
time for file in $files; do
    python3 load_tweets.py --db postgresql://postgres:pass@localhost:2067 --input "$file"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
