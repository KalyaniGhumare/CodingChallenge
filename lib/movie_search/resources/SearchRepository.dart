
import 'package:Movies/movie_search/resources/SearchProvider.dart';
import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';

class SearchRepository{
	final searchProvider = SearchProvider();
	
	Future<NowPlayingMoviesReponse> fetchSearchinData(String key) => searchProvider.fetchSearchinData(key);
}