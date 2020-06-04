import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';
import 'package:Movies/utils/Constants.dart';
import 'package:Movies/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieDetailsScreen extends StatefulWidget
{
  /*
  * Global Instance of Movie
  * */
  final Movie movie;
  
  /*
  * Constructor
  * */
  MovieDetailsScreen({this.movie});
  
  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends State<MovieDetailsScreen>
{
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        brightness: Brightness.light,
        title: Text(widget.movie.title,
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*
                  * Poseter of Movie
                  * */
                  Container(
                    height: 220.0,
                    width: 140.0,
                    child: Image.network(Constants.TEXT_IMAGE_HOST + widget.movie.posterPath,  fit: BoxFit.fill),
                  ),
                  SizedBox(width: 20.0),
                  /*
                  * Other Details
                  * Language, Released Date
                  * */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*
                        * Display
                        * Movie Language
                        * */
                        singleDetail(Icons.language, widget.movie.originalLanguage),
                        /*
                        * Display
                        * Movie Release Date
                        * */
                        singleDetail(Icons.date_range, widget.movie.releaseDate),
                        /*
                        * Display
                        * Movie Popularity
                        * */
                        singleDetail(Icons.thumb_up, widget.movie.popularity.toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.0),
            /*
            * Display
            * Original Title
            * */
            singleData('ORIGINAL TITLE', widget.movie.originalTitle),
            /*
            * Display
            * Vote Count
            * */
            SizedBox(height: 16.0),
            singleData('VOTE COUNT', widget.movie.voteCount.toString()),
  
            /*
            * Display
            * Movie Vote Average
            * */
            SizedBox(height: 16.0),
            singleData('VOTE AVERAGE', widget.movie.voteAverage.toString()),
            
            /*
            * Display
            * Overview
            * */
            SizedBox(height: 16.0),
            singleData('OVERVIEW', widget.movie.overview)
          ],
        ),
      ),
    );
  }
  
  singleDetail(IconData iconData, String title)
  {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 26.0,
            color: Colors.green[600],
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: TextWidget(
                title,
                18.0,
                Colors.black,
                FontWeight.normal,
                TextAlign.start
            ),
          )
        ],
      ),
    );
  }
  
  singleData(String heading, String value)
  {
    return Column(
      children: [
        TextWidget(
            heading,
            16.0,
            Colors.black,
            FontWeight.normal,
            TextAlign.start
        ),
        SizedBox(height: 8.0),
        TextWidget(
            value,
            14.0,
            Colors.black,
            FontWeight.normal,
            TextAlign.start
        ),
      ],
    );
  }
}
