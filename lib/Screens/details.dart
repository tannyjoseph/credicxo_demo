import 'package:credicxodemo/BLoC/SongDetail.dart';
import 'package:credicxodemo/BLoC/bloc_provider.dart';
import 'package:credicxodemo/Data/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Details extends StatefulWidget {
  final String artistName;
  final String trackName;
  final String albumName;
  final String ex;
  final String rating;
  final int id;

  Details(
      {this.artistName,
      this.trackName,
      this.albumName,
      this.ex,
      this.rating,
      this.id});

  @override
  State<StatefulWidget> createState() {
    return DetailsState(
        artistName: artistName,
        trackName: trackName,
        albumName: albumName,
        ex: ex,
        rating: rating,
        id: id);
  }
}

class DetailsState extends State<Details> {
  final String artistName;
  final String trackName;
  final String albumName;
  final String ex;
  final String rating;
  final int id;

  SongDetailBloc bloc;

  DetailsState(
      {this.artistName,
      this.trackName,
      this.albumName,
      this.ex,
      this.rating,
      this.id});

  @override
  void didChangeDependencies() {
    bloc = SongDetailBlocProvider.of(context);
    bloc.fetchTrailersById(id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf05454),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Track Details", style: TextStyle(color: Colors.white)),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Center(
            child: connected
                ? SafeArea(
                    child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$trackName',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'Artist',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$artistName',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'Album Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$albumName',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'Explicit',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$ex', style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'Rating',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$rating', style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'Lyrics',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0)),
                              StreamBuilder(
                                stream: bloc.movieTrailers,
                                builder: (context,
                                    AsyncSnapshot<Future<Lyrics>> snapshot) {
                                  if (snapshot.hasData) {
                                    return FutureBuilder(
                                      future: snapshot.data,
                                      builder: (context,
                                          AsyncSnapshot<Lyrics> itemSnapShot) {
                                        if (itemSnapShot.hasData) {
                                          if (itemSnapShot.data.results.length >
                                              0)
                                            return trailerLayout(
                                                itemSnapShot.data);
                                          else
                                            return noTrailer(itemSnapShot.data);
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
                : Text(
                    'No Internet Connection',
                  ),
          );
        },
        child: Container(),
      ),
    );
  }
}

Widget noTrailer(Lyrics data) {
  return Center(
    child: Container(
      child: Text("No trailer available"),
    ),
  );
}

Widget trailerLayout(Lyrics data) {
  if (data.results.length > 1) {
    return Row(
      children: <Widget>[
        trailerItem(data, 0),
        trailerItem(data, 1),
      ],
    );
  } else {
    return Row(
      children: <Widget>[
        trailerItem(data, 0),
      ],
    );
  }
}

trailerItem(Lyrics data, int index) {
  return Expanded(
    child: Column(
      children: <Widget>[
        Text(data.results[index].lyricsBody, style: TextStyle(fontSize: 20)),
      ],
    ),
  );
}
