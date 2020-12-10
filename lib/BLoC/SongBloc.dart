import 'dart:async';
import 'package:credicxodemo/Data/fetch.dart';
import 'package:credicxodemo/Data/trending.dart';
import 'package:rxdart/rxdart.dart';

class SongBloc {
  final _repository = Fetch();
  final _musicFetcher = PublishSubject<Trending>();

  Stream<Trending> get allMusic => _musicFetcher.stream;

  fetchAllMusic() async {
    if(_isDisposed) {
      return;
    }
    Trending itemModel = await _repository.fetchAllMusic();
    _musicFetcher.sink.add(itemModel);
  }
  bool _isDisposed = false;

  dispose() {
    _musicFetcher.close();
    _isDisposed = true;
  }
}

final bloc = SongBloc();
