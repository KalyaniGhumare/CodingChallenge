import 'package:Movies/movie_search/resources/SearchRepository.dart';
import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';
import 'package:rxdart/rxdart.dart';

class SearchingBloc{
	final repository = SearchRepository();
	final searchFetcher = PublishSubject<NowPlayingMoviesReponse>();
	
	Observable<NowPlayingMoviesReponse> get searchData => searchFetcher.stream;
	
	fetchSearching(String key) async {
		NowPlayingMoviesReponse searchModel = await repository.fetchSearchinData(key);
		searchFetcher.add(searchModel);
	}
	
	dispose()
	{
		searchFetcher.close();
	}
}
final blocSearching = SearchingBloc();