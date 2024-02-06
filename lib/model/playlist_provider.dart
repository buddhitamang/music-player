

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/model/song.dart';

class PlayListProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'dj khalid',
        artistName: 'Bruno march',
        imagePath: 'assests/images/img1.jpg',
        audioPath: 'assests/audios/music1.mp3'),
    Song(
        songName: 'love you',
        artistName: 'wix khanclif',
        imagePath: 'assests/images/img2.jpeg',
        audioPath: 'assests/audios/music1.mp3'),
    Song(
        songName: 'perfect',
        artistName: 'Ed sheren',
        imagePath: 'assests/images/img3.jpg',
        audioPath: 'assests/audios/music1.mp3'),
  ];
  int? _currentSongIndex;

  /*
  A U D I O
  */

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructors
  PlayListProvider() {
    listenToDuration();
  }

  //Initialyy not playing
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume(){
    if(_isPlaying){
      pause();
    }else{
      resume();

    }
    notifyListeners();
  }

  //seek to specific position int the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);

  }

  //play next song
  void playNextSong(){
    if(_currentSongIndex!=null){
      if(_currentSongIndex! < _playlist.length -1){
        //go to next song if it's not the last song
        _currentSongIndex=_currentSongIndex! +1;
      }else{
        //if it's the last song, loop back to the first song
        currentSongIndex=0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async{
    //if more than 2 second have passes, restart the song
    if(_currentDuration.inSeconds>2){

    }
    //if its within first 2 second of the song, go to previous song
    else{
      if(_currentSongIndex! >0){
        currentSongIndex=_currentSongIndex!-1;
      }else{
        //if its first song , loop back to the last song
        currentSongIndex=_playlist.length-1;
      }

    }
  }

  //listen to durration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  //getter function
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying=>_isPlaying;
  Duration get currentDuration=>_currentDuration;
  Duration get totalDuration=>_totalDuration;

  //seeter function
  set currentSongIndex(int? newIndex) {
    //update
    _currentSongIndex = newIndex;
    if(newIndex!=null){
      play();//play the song at the new index
    }

    //update the ui
    notifyListeners();
  }
}
