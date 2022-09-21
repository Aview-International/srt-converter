const fs = require("fs");

const vId = process.argv[2];
const title = process.argv[3].slice(1, -1);
const subs = require(`./jsonSubs/${vId}.json`);



const main = async () => {
  let srtCount = 0;
  function srtTimestamp(time) {
    let milliseconds = Math.floor(time * 1000);

    let seconds = Math.floor(milliseconds / 1000);
    let minutes = Math.floor(seconds / 60);
    let hours = Math.floor(minutes / 60);
    milliseconds = milliseconds % 1000;
    seconds = seconds % 60;
    minutes = minutes % 60;
    return (
      (hours < 10 ? "0" : "") +
      hours +
      ":" +
      (minutes < 10 ? "0" : "") +
      minutes +
      ":" +
      (seconds < 10 ? "0" : "") +
      seconds +
      "," +
      (milliseconds < 100 ? "0" : "") +
      (milliseconds < 10 ? "0" : "") +
      milliseconds
    );
  }

  function inputToSRT(sub_in) {
    return (
      ++srtCount +
      "\r\n" +
      srtTimestamp(sub_in.start) +
      " --> " +
      srtTimestamp(sub_in.end) +
      "\r\n" +
      sub_in.text +
      "\r\n\r\n"
    );
  }

  const subtitles =
    subs.actions[0].updateEngagementPanelAction.content.transcriptRenderer.body.transcriptBodyRenderer.cueGroups.map(
      (sub) => ({
        start:
          sub.transcriptCueGroupRenderer.cues[0].transcriptCueRenderer
            .startOffsetMs / 1000,
        end:
          sub.transcriptCueGroupRenderer.cues[0].transcriptCueRenderer
            .startOffsetMs /
            1000 +
          sub.transcriptCueGroupRenderer.cues[0].transcriptCueRenderer
            .durationMs /
            1000,
        text: sub.transcriptCueGroupRenderer.cues[0].transcriptCueRenderer.cue
          .simpleText,
      })
    );

  fs.writeFile(`./srts/${title}.srt`, "", function (err) {
    if (err) throw err;
  });

  for (var i = 0; i < subtitles.length; i++) {
    fs.appendFileSync(`./srts/${title}.srt`, inputToSRT(subtitles[i]), function (err) {
      if (err) throw err;
    });
  }
};

main()
  .then(() => console.log("Your SRT file has been generated."))
  .catch(() => console.log("Error!"));
