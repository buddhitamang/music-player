
import 'package:flutter/material.dart';

class SongsTiles extends StatelessWidget {
  final String songTitle;

  const SongsTiles({super.key,required this.songTitle});
  // const SongsTiles({super.key, required this.songTitle});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      width: 200,
      color: Colors.white,
      child: Image(
        image: AssetImage(songTitle),
        fit: BoxFit.cover,
      ),
    );
  }
}
