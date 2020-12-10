import 'dart:async';

import 'package:credicxodemo/Data/MusicClient.dart';
import 'package:credicxodemo/Data/details.dart';

import 'trending.dart';

class Fetch {
  final musicApiProvider = MusicClient();

  Future<Trending> fetchAllMusic() => musicApiProvider.fetchMusicList();

  Future<Lyrics> fetchLyrics(int id) => musicApiProvider.fetchLyrics(id);
}
