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
2. Run sh convert.sh.
3. The generated srt file is named f.srt and would be found in the srts folder.
(Note: The generated srt file overwrites the existing f.srt in the folder.)

### Sample 
```
sh convert.sh
Input URL and language initials: https://www.youtube.com/watch?v=VIDEOID ja
```
If language initials are not provided, the script would default to English.

### Language Initials Reference
You can refer [here](https://www.embedplus.com/youtube-iso-639-1-language-codes.aspx) for reference on the initials used by YouTube for each language.

---

## Limitations

1. This only works on utf8 captions. Non-utf8 characters are stripped out. 
2. The formatting is not preserved if the creator-provided captions have some.
