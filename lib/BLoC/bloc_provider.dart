import 'package:flutter/material.dart';
import 'SongDetail.dart';

class SongDetailBlocProvider extends InheritedWidget {
  final SongDetailBloc bloc;

  SongDetailBlocProvider({Key key, Widget child})
      : bloc = SongDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static SongDetailBloc of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<SongDetailBlocProvider>())
        .bloc;
  }
}
