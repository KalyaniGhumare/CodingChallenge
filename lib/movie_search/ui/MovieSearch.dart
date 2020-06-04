import 'package:Movies/movie_details/ui/MovieDetailsScreen.dart';
import 'package:Movies/movie_search/bloc/SearchBloc.dart';
import 'package:Movies/now_playing_movies/model/NowPlayingMovieModel.dart';
import 'package:Movies/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget
{
	@override
	SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
{
	/*
	* Global Instance of Controller
	* */
	TextEditingController searchController = new TextEditingController();
	
	/*
	* Global Instance of SearchBloc
	* */
	SearchingBloc searchingBloc;
	
	@override
  	void initState() {
   
		/*
		* Inti Instance of SearchBloc
		* */
		searchingBloc = SearchingBloc();
		
		super.initState();
  	}
	@override
	Widget build(BuildContext context)
	{
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.orange,
				
				title: Text("Search Movie", style: TextStyle(color: Colors.white)),
			),
			body: Container(
				child: Column(
					children: <Widget>[
						Card(
							margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 15.0),
							elevation: 2.0,
							child: Container(
								child: TextFormField(
									onChanged: (value)
									{
										if(value.length > 0)
										{
											blocSearching.fetchSearching(value);
										}
									},
									autofocus: true,
									decoration: InputDecoration(
										labelText: "Search Movie Here",
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(5.0),
											borderSide: BorderSide(color: Colors.white,),
										),
										enabledBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Colors.white,),
											borderRadius: BorderRadius.circular(5.0),
										),
										hintText: "Search..",
										prefixIcon: Icon(
											Icons.search,
											color: Colors.black38,
										),
										hintStyle: TextStyle(
											fontSize: 15.0,
											color: Colors.black38,
										),
									),
									style: TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: "ProductSans"),
								),
							),
						),
						SizedBox(height: 10.0),
						Expanded(
							child: StreamBuilder(
								stream: blocSearching.searchData,
								builder: (context, AsyncSnapshot<NowPlayingMoviesReponse> snapShot)
								{
									if (snapShot.hasData)
										return loadSearchData(snapShot.data.moviesList);
									else if (snapShot.hasError)
										return Text(snapShot.hasError.toString());
									
									return Container();
								},
							),
						)
					],
				),
			),
		);
	}
	
	
	/*
	* Load Search Data
	* */
	Widget loadSearchData(List<Movie> searchDataList)
	{
		return searchDataList.isEmpty
			? Container(
				height: MediaQuery.of(context).size.height,
				width: MediaQuery.of(context).size.width,
				alignment: Alignment.center,
				child: CircularProgressIndicator(),
			)
			: ListView.builder(
				itemCount: searchDataList.length,
				itemBuilder: (BuildContext context, int index) {
					return singleSearchMovie(searchDataList[index]);
				});
	}
	
	/*
	* Display Single Movie Card
	* */
	Widget singleSearchMovie(Movie searchDataList)
	{
		return InkWell(
			onTap: () => openMovieDetailsScreen(searchDataList),
			child: Card(
				elevation: 6.0,
				margin: EdgeInsets.only(left: 6.0, right: 6.0,bottom: 6.0),
				child: Container(
					height: 50.0,
					alignment: Alignment.centerLeft,
					margin: EdgeInsets.symmetric(horizontal: 8.0),
					child: searchDataList.title == null ||
		  				searchDataList.title.isEmpty
						? Container()
						: TextWidget(
							searchDataList.title,
							16.0,
							Colors.black,
							FontWeight.normal,
							TextAlign.start
						)
				),
		  ),
		);
	}

	/*
	* Open Movie Details Screen
	* On Tap On Movie Name
	* */
  	openMovieDetailsScreen(Movie movie) async {
		await Navigator
			.of(context)
			.push(MaterialPageRoute(builder: (BuildContext context) => MovieDetailsScreen(movie: movie)));
	}
}
