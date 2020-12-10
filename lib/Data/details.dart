class Lyrics {
  List<_Songs> _songs = [];

  Lyrics.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['message']['body']['lyrics']['lyrics_body'].length);
    List<_Songs> temp = [];
    _Songs result = _Songs(parsedJson['message']['body']['lyrics']);
    temp.add(result);
    _songs = temp;
  }

  List<_Songs> get results => _songs;
}

class _Songs {
  String lyricsBody;

  _Songs(result) {
    this.lyricsBody = result['lyrics_body'];
    print(lyricsBody);
  }
}
