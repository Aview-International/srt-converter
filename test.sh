file='links.txt'

while read line lang || [ -n "$line" ]; do 
    vId=${line:32:11}
    echo $vId;
    echo $lang; 
done < $file

