file='links.txt'

while read line lang || [ -n "$line" ]; do 
    vId=${line:32:11}
    if [ -z $vId ]
    then
        echo "Cannot have empty input!"
    else
        if [ -z $lang ] || [ "$lang" = "en" ]
        then
            params="$(printf "\n\x0b$vId" | base64)"
        else
            A="$(printf "\n\x00\x12\x02$lang\x1a\x00" | base64)"
            B="$(printf %s $A | jq -sRr @uri)"
            C="$(echo $B | sed 's/%/%%/')"  
            params="$(printf "\n\x0b$vId\x12\x0e$C" | base64)"
        fi
        rawData="{\"context\":{\"client\":{\"clientName\":\"WEB\",\"clientVersion\":\"2.2021111\"}},\"params\":\"$params\"}"
        if [ -z $lang ]
        then
            curl -s 'https://www.youtube.com/youtubei/v1/get_transcript?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8' -H 'Content-Type: application/json' --data-raw $rawData -o ./jsonSubs/$vId.json
        else
            curl -s 'https://www.youtube.com/youtubei/v1/get_transcript?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8' -H 'Content-Type: application/json' --data-raw $rawData -o ./jsonSubs/$vId$lang.json
        fi
        title="$(curl -s "https://noembed.com/embed?url=https://www.youtube.com/watch?v=$vId" | jq ".title")"
        node ./index.js $vId "$title" $lang
    fi
done < $file
