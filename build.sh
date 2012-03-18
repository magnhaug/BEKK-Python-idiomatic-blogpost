#/bin/bash

while true
do
    cat head.html > index.html
    markdown README.md >> index.html
    echo "</body></html></article>" >> index.html
    sleep 1
done
