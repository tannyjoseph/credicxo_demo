class Trending {
  List<_Song> _songs = [];

  Trending.fromJson(Map<String, dynamic> parsedJson) {
//    print(parsedJson['message']['body']['track_list'].length);
    List<_Song> temp = [];
    for (int i = 0;
        i < parsedJson['message']['body']['track_list'].length;
        i++) {
      _Song result =
          _Song(parsedJson['message']['body']['track_list'][i]['track']);
      temp.add(result);
    }
    _songs = temp;
  }

  List<_Song> get results => _songs;
}

class _Song {
  String name;
  int id;
  String album;
  String artist;
  String ex;
  String rating;

  _Song(result) {
    this.name = result['track_name'];
    this.album = result['album_name'];
    this.artist = result['artist_name'];
    this.id = result['track_id'];
    this.ex = result['explicit'] == 1 ? 'True' : 'False';
    this.rating = result['track_rating'].toString();
  }
}
