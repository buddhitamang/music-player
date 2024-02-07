import 'package:flutter/material.dart';
import 'package:musicplayer/Pages/song_page.dart';
import 'package:provider/provider.dart';

import '../model/playlist_provider.dart';
import '../model/song.dart';

class ArtistSong extends StatefulWidget {
  const ArtistSong({Key? key}) : super(key: key);

  @override
  State<ArtistSong> createState() => _ArtistSongState();
}

class _ArtistSongState extends State<ArtistSong> {
  late final PlayListProvider playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  // Go to song
  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Consumer<PlayListProvider>(
          builder: (context, value, child) {
              final Song currentSong = value.playlist[value.currentSongIndex!];
              return Text("P L A Y L I S T  O F "+currentSong.artistName);
          },
        ),
      ),
      body: Consumer<PlayListProvider>(
        builder: (BuildContext context, PlayListProvider value, Widget? child) {
          final List<Song> playlist = value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      song.imagePath,
                    ),
                  ),
                  title: Text(song.artistName),
                  subtitle: Text(song.songName),
                  onTap: () => goToSong(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
