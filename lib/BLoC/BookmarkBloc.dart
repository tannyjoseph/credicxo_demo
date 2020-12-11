import 'dart:async';

import 'package:credicxodemo/Data/trending.dart';

class FavoriteBloc {
  var _songs = <Trending>[];
  List<Trending> get favorites => _songs;

  // 1
  final _controller = StreamController<List<Trending>>.broadcast();
  Stream<List<Trending>> get bookmarks => _controller.stream;

  void toggleBookmarks(Trending song) {
    if (_songs.contains(song)) {
      _songs.remove(song);
    } else {
      _songs.add(song);
    }

    _controller.sink.add(_songs);
  }

  void dispose() {
    _controller.close();
  }
}
