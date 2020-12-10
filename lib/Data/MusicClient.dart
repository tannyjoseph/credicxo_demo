import 'dart:convert';
import 'package:credicxodemo/Data/trending.dart';
import 'details.dart';
import 'package:http/http.dart' show Client;

class MusicClient {
  Client client = new Client();

  Future<Trending> fetchMusicList() async {
    print("entered");
    final response = await client.get(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Trending.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Lyrics> fetchLyrics(int trackId) async {
    final response = await client.get(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");

    if (response.statusCode == 200) {
      return Lyrics.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
