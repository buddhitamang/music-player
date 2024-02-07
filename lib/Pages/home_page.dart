import 'package:flutter/material.dart';
import 'package:musicplayer/Pages/artist_song.dart';
import 'package:musicplayer/Pages/song_page.dart';
import 'package:musicplayer/components/songs_tile.dart';
import 'package:musicplayer/model/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../model/song.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
   late final dynamic playListProvider;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get playlist provider'
     playListProvider=Provider.of<PlayListProvider>(context, listen: false);
  }

  //got to song
   void goToSong(int songIndex){
     playListProvider.currentSongIndex=songIndex;
     Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistSong()));

   }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(child: Icon(Icons.person)),
          ),
        ],
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Buddhi',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Find the best song of 2024',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black38,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find your music',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Popular Artist',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Container(
                height: 250,
                child: Consumer<PlayListProvider>(
                  builder: (BuildContext context, PlayListProvider value,
                      Widget? child) {
                    final List<Song> playlist = value.playlist;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        final Song song = playlist[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: () {
                                  return goToSong(index);
                                },
                                child: Container(
                                  color: Colors.grey.shade500,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          song.imagePath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 8), // Adjust spacing between image and text
                                      Text(
                                        song.artistName,
                                        textAlign: TextAlign.center, // Adjust text alignment as needed
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
