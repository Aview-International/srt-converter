# srt-converter
This script retrieves the caption of a YouTube video per language in SRT format.

---
## Dependencies
- jq
- Node.js
- curl
---
## How to Use

1. Install dependencies.
2. Put video links in links.txt.
3. Run sh convert.sh.
4. The generated srt files  would be found in the srts folder.
(Note: The generated srt files overwrites the existing srts in the folder if it is duplicate.)

### Sample 
In links.txt:
```
https://www.youtube.com/watch?v=HjEqOWjTkHE&ab_channel=MarquesBrownlee
https://www.youtube.com/watch?v=XsGOQP-B0gU&ab_channel=LoganPaul ar
https://www.youtube.com/watch?v=dg2Ag3e8W-Q&ab_channel=MrBeast de
```
If language initials are not provided, the script would default to the video's default set language.

### Language Initials Reference
You can refer [here](https://www.embedplus.com/youtube-iso-639-1-language-codes.aspx) for reference on the initials used by YouTube for each language.

---

## Limitations

1. This only works on utf8 captions. Non-utf8 characters are stripped out. 
2. The formatting is not preserved if the creator-provided captions have some.
3. Videos with no captions (auto-generated is ) will fail to work with this script.
