
import 'package:flutter/material.dart';
import 'package:musicplayer/model/playlist_provider.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PlayListProvider(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',

        debugShowCheckedModeBanner: false,
        home: HomePage());

  }
}
