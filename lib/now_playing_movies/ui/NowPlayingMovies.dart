import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Movies/movie_details/ui/MovieDetailsScreen.dart';
import 'package:Movies/movie_search/ui/MovieSearch.dart';
import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';
import 'package:Movies/utils/Constants.dart';
import 'package:Movies/utils/URLs.dart';
import 'package:Movies/widgets/TextWidget.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_paginator/enums.dart';
import 'package:flutter_paginator/flutter_paginator.dart';

class NowPlayingMovies extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => NowPlayingMoviesState();
}

class NowPlayingMoviesState extends State<NowPlayingMovies>
{
  /*
  * Global Instance of PaginatorState
  * */
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Now Playing Movie", style: TextStyle(color: Colors.white)),
        actions: <Widget>
        [
          /*
          * Search
          * */
          singleIconButton(Icons.search, () => openSearchScreen()),
        ],
      ),
      body: Paginator.gridView(
        key: paginatorGlobalKey,
        pageLoadFuture: requestToServerNowPlayingMovieData,
        pageItemsGetter: listItemsGetter,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
  
  /*
  * Method Fetch Data
  * From Server
  * Using Http
  * */
  Future<NowPlayingMoviesReponse> requestToServerNowPlayingMovieData(int page) async
  {
    try
    {
      /*
      * Request URL
      * */
      String url = Uri.encodeFull(URLs.API_READ_NOW_PLAYING_MOVIES + "?api_key=719296058598aec4f454164c24d792c3&page=$page");
      
      /*
      * Request to Server
      * */
      http.Response response = await http.get(url);
      
      /*
      * Decode Server Response
      * */
      var responseJson = json.decode(response.body.toString());
      
      /*
      * return response
      * */
      return NowPlayingMoviesReponse.fromJson(responseJson);
      
    }
    catch (e)
    {
      /*
      * Display Error message according to the
      * exception
      * */
      if (e is IOException)
      {
        return NowPlayingMoviesReponse.withError(Constants.TEXT_NO_INTERNET_CONNECTION);
      }
      else
      {
        return NowPlayingMoviesReponse.withError(Constants.TEXT_ERROR_DURING_COMMUNICATION);
      }
    }
  }
  
  /*
  * Method
  * All Movie List
  * */
  List<Movie> listItemsGetter(NowPlayingMoviesReponse nowPlayingMovieData)
  {
    return nowPlayingMovieData.moviesList;
  }
  
  /*
  * Display
  * Single Movie Details
  * Card
  * */
  Widget listItemBuilder(movieList, int index)
  {
    String imageUrl = '';
    /*
    * Check
    * Poster Path is null or not
    * */
    if(movieList.posterPath != null)
    {
      imageUrl = Constants.TEXT_IMAGE_HOST + movieList.posterPath;
    }
    return InkWell(
      onTap: () => openMovieDetailsScreen(movieList),
      child: Card(
        elevation: 6.0,
        child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                /*
                * Movie Poster Path
                * */
                imageUrl.isEmpty
                    ? Container(color: Colors.orange[200])
                    : Image.network(imageUrl, width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
                Container(
                  padding: EdgeInsets.only(left: 12.0, bottom: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /*
                      * Movie Title
                      * */
                      movieList.title != null
                          ? TextWidget(
                              movieList.title,
                              20.0,
                              Colors.white,
                              FontWeight.bold,
                              TextAlign.start
                          )
                          : Container(),
                      /*
                      * Movie originalTitle
                      * */
                      movieList.originalTitle != null
                          ? TextWidget(
                              movieList.originalTitle,
                              16.0,
                              Colors.white,
                              FontWeight.normal,
                              TextAlign.start
                          )
                          : Container(),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
  
  /*
  * Method
  * Loading Widget
  * */
  Widget loadingWidgetMaker()
  {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }
  
  /*
  * Method Error Widget Marker
  * */
  Widget errorWidgetMaker(NowPlayingMoviesReponse nowPlayingMovieData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(nowPlayingMovieData.errorMessage, style: TextStyle(fontSize: 20.0, color: Colors.deepOrange)),
        ),
        RaisedButton(
          color: Colors.orange,
          child: Text(Constants.TEXT_RETRY, style: TextStyle(color: Colors.white)),
          onPressed: retryListener,
        )
      ],
    );
  }
  
  /*
  * Method
  * empty List Marker
  * */
  Widget emptyListWidgetMaker(NowPlayingMoviesReponse nowPlayingMovieData) {
    return Center(
      child: Text(Constants.TEXT_NO_MOVIE_LIST, style: TextStyle(fontSize: 18.0, color: Colors.deepOrange)),
    );
  }
  
  /*
  * Method
  * Total Page Reults
  * */
  int totalPagesGetter(NowPlayingMoviesReponse nowPlayingMovieData)
  {
    return nowPlayingMovieData.totalResults;
  }

  /*
  * Method
  * Page Error Checker
  * */
  bool pageErrorChecker(NowPlayingMoviesReponse nowPlayingMovieData)
  {
    return nowPlayingMovieData.statusCode != 200;
  }

  
  /*
  * Open Screen
  * On Tap On Movie
  * Display Movie Details
  * */
  void openMovieDetailsScreen(Movie movie) async
  {
    await Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => MovieDetailsScreen(movie: movie)));
  }

  /*
  * Open Screen
  * On Tap On Search Icon
  * Open Movie Search Screen
  * */
  void openSearchScreen() async
  {
    print("Click on search");
    
    await Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
  }
  
  /*
  * Widget
  * Icon Button
  * */
  singleIconButton(IconData iconData, Function() function)
  {
    return IconButton(
      icon: Icon(iconData, size: 26.0, color: Colors.white),
      onPressed: function,
    );
  }
}

