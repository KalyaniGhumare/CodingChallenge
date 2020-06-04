import 'package:Movies/now_playing_movies/ui/NowPlayingMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    /*
    * set Protrait Mode
    * */
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    
    return MaterialApp(
      home: NowPlayingMovies(),
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        primaryColorDark: Colors.orangeAccent,
        accentColor: Colors.red,),
    );
  }
}

