import 'package:flutter/material.dart';
import 'package:musicplayer/Pages/home_page.dart';
import 'package:musicplayer/components/neu_box.dart';
import 'package:musicplayer/model/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, index) {
      //get playlist
      final playlist = value.playlist;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              children: [
                //app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      'P L A Y L I S T S',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.menu)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //album art work
                Container(
                  width: 400,
                  height: 400,
                  child: NeuBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          currentSong.imagePath,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //song duration progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0.00'),
                    Icon(Icons.shuffle),
                    Icon(Icons.repeat),
                    Text('0.00')
                  ],
                ),

                //playbacks controls
                SliderTheme(
                  //this is for removing dot in the slider
                  data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)),
                  child: Slider(
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    activeColor: Colors.grey,
                    value: value.currentDuration.inSeconds.toDouble(),
                    onChanged: (double double) {
                      //during when the user is sliding around
                    },
                    onChangeEnd: (double double) {
                      //sliding has finished, go to that position in song duration
                      value.seek(Duration(seconds: double.toInt()));
                    },
                  ),
                ),

                //playback controls
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                            child: NeuBox(child: Icon(Icons.skip_previous)))),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                            child: NeuBox(child: value.isPlaying? Icon(Icons.pause) : Icon(Icons.play_arrow)))),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                            child: NeuBox(child: Icon(Icons.skip_next)))),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
