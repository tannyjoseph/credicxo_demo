import 'package:credicxodemo/Screens/SongsScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MusicFinder());

class MusicFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Music And You",
        home: TrendingSongs());
  }
}
