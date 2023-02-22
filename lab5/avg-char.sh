#/bin/bash

CHARS=$(wc -c < file1)
LINES=$(wc -l < file1)
echo $CHARS
echo $LINES

AVG=$((CHARS / LINES))
echo "Average number of chars per line: $AVG"

