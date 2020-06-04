class NowPlayingMoviesReponse {
	List<Movie> moviesList;
	int page;
	int totalResults;
	Dates dates;
	int totalPages, statusCode;
	String errorMessage;
	
	NowPlayingMoviesReponse.fromJson(Map<String, dynamic> json)
	{
		this.statusCode = 200;
		if (json['results'] != null)
		{
			moviesList = new List<Movie>();
			json['results'].forEach((v) {
				moviesList.add(new Movie.fromJson(v));
			});
		}
		page = json['page'];
		totalResults = json['total_results'];
		dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
		totalPages = json['total_pages'];
	}
	
	NowPlayingMoviesReponse.withError(String errorMessage) {
		this.errorMessage = errorMessage;
	}
}

class Movie
{
	var popularity,
		voteAverage,
		id,
		voteCount;
	
	bool adult,
		video;
	
	String posterPath,
		backdropPath,
		originalLanguage,
		originalTitle,
		title,
		overview,
		releaseDate;
	
	List<int> genreIds;
	
	Movie.fromJson(Map<String, dynamic> json) {
		popularity = json['popularity'];
		voteCount = json['vote_count'];
		video = json['video'];
		posterPath = json['poster_path'];
		id = json['id'];
		adult = json['adult'];
		backdropPath = json['backdrop_path'];
		originalLanguage = json['original_language'];
		originalTitle = json['original_title'];
		genreIds = json['genre_ids'].cast<int>();
		title = json['title'];
		voteAverage = json['vote_average'];
		overview = json['overview'];
		releaseDate = json['release_date'];
	}
}

class Dates
{
	String maximum,
		minimum;
	
	Dates.fromJson(Map<String, dynamic> json) {
		maximum = json['maximum'];
		minimum = json['minimum'];
	}
}