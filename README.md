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
Input URL: https://www.youtube.com/watch?v=VIDEOID
Input language (default: en, options: ru, ja, de, etc.): es
```

### Language Initials Reference
You can refer [here](https://www.embedplus.com/youtube-iso-639-1-language-codes.aspx) for reference on the initials used by YouTube for each language.

---

## Limitations
1. This script only works for videos with creator-provided captions. This does not include auto-generated captions.

2. There is buggy behavior when tried to use on captions that have multiple lines running at the same time or have non-utf8 characters.
