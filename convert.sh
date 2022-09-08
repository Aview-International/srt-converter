read -p "Input URL: " vUrl
vId=${vUrl:32:11}
if [ -z $vId ]
then
    echo "Cannot have empty input!"
else
    read -p "Input language (default: en, options: ru, ja, de, etc.): " lang
    echo
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
    curl -s 'https://www.youtube.com/youtubei/v1/get_transcript?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8' -H 'Content-Type: application/json' --data-raw $rawData -o ./jsonSubs/f.json
    node ./index.js
    
fi