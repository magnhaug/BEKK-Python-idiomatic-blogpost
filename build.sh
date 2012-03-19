#/bin/bash

while true
do
    for f in *.md
    do
        base="${f%.*}"
        cat head.html > $base.html
        markdown $f >> $base.html
        echo "</body></html></article>" >> $base.html
    done
    sleep 1
done
