import 'package:credicxodemo/BLoC/SongBloc.dart';
import 'package:credicxodemo/BLoC/bloc_provider.dart';
import 'package:credicxodemo/Data/trending.dart';
import 'package:credicxodemo/Screens/detailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class TrendingSongs extends StatefulWidget {
  @override
  _TrendingSongsState createState() => _TrendingSongsState();
}

class _TrendingSongsState extends State<TrendingSongs> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMusic();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMusic();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf05454),
        title: Center(
            child: Text(
          'Trending',
          style: TextStyle(color: Colors.white),
        )),
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
                ? startListing()
                : Text(
                    'No Internet Connection',
                  ),
          );
        },
        child: Container(),
      ),
    );
  }

  Widget startListing() {
    bloc.fetchAllMusic();
    return StreamBuilder(
      stream: bloc.allMusic,
      builder: (context, AsyncSnapshot<Trending> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<Trending> snapshot) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Card(
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Icon(
                                Icons.library_music,
                                color: Colors.black26,
                                size: 28,
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(snapshot.data.results[index].name),
                                subtitle: Text(snapshot.data.results[index].album),
                              ),
                              flex: 7,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Text(snapshot.data.results[index].artist),
                              ),
                              flex: 4,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () => openDetailPage(snapshot.data, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  openDetailPage(Trending data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SongDetailBlocProvider(
            child: Details(
                artistName: data.results[index].artist,
                trackName: data.results[index].name,
                albumName: data.results[index].album,
                ex: data.results[index].ex,
                rating: data.results[index].rating,
                id: data.results[index].id),
          );
        },
      ),
    );
  }
}
