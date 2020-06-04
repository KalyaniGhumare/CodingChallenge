import 'dart:convert';

import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';
import 'package:Movies/utils/URLs.dart';
import 'package:http/http.dart';

class SearchProvider
{
	
	Client client = Client();
	
	Future<NowPlayingMoviesReponse> fetchSearchinData(String key) async
	{
		try
		{
			String url = URLs.API_SEARCH_MOVIES + "?api_key=719296058598aec4f454164c24d792c3&query=$key";
			
			print("url $url");
			
			final response = await client.get(url);
			
			print("All Movie:- "+response.body.toString());
			
			if(response.statusCode == 200)
			{
				print("json.decode(response.body) ${json.decode(response.body)}");
				
				return NowPlayingMoviesReponse.fromJson(json.decode(response.body));
			}
			else
			{
				return NowPlayingMoviesReponse.fromJson(json.decode(response.body));
			}
		}
		catch(e)
		{
			print("search catch $e");
		}
		
		return null;
	}
}