import 'dart:async';
import 'package:credicxodemo/Data/details.dart';
import 'package:credicxodemo/Data/fetch.dart';
import 'package:rxdart/rxdart.dart';

class SongDetailBloc {
  final _fetch = Fetch();
  final _trackId = PublishSubject<int>();
  final _lyrics = BehaviorSubject<Future<Lyrics>>();

  Function(int) get fetchTrailersById => _trackId.sink.add;

  Stream<Future<Lyrics>> get movieTrailers => _lyrics.stream;

  SongDetailBloc() {
    _trackId.stream.transform(_itemTransformer()).pipe(_lyrics);
  }

  dispose() async {
    _trackId.close();
    await _lyrics.drain();
    _lyrics.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<Lyrics> trailer, int id, int index) {
        print(index);
        trailer = _fetch.fetchLyrics(id);
        return trailer;
      },
    );
  }
}
