import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_cubit.dart';
import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_state.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_cubit.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_state.dart';
import 'package:fh_movie_app/features/ui/movieDetailsScreen/widgets/chips.dart';
import 'package:fh_movie_app/features/ui/movieDetailsScreen/widgets/videos_corusal_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/endpoints.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsResponse? movie;
  bool isFavorite=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit,FavoriteMoviesState>(
        builder: (context,state){

          if(state is FavoriteMoviesSuccessState ) {
             isFavorite = state.movieList.where((element)=>element.id==widget.movieId)
                .toList().isNotEmpty;
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title:Text("THMDB"),
                actions: [
                  IconButton(onPressed: (){
                    context.read<FavoritesCubit>().toggleFavoriteMovie(widget.movieId,movie!);
                  }, icon:isFavorite?Icon(Icons.favorite,color: Colors.red,)
                      :Icon(Icons.favorite_outline_rounded))
                ],
                leading: IconButton(
                  icon:Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },),),
              body:BlocConsumer<MovieDetailsCubit,MovieDetailsState>(
                listener:(context,state){},
                builder:(context,state){
                  if(state is MovieDetailsLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(state is  MovieDetailsSuccessState){
                    movie=state.movie;
                    List<String> genresList=[];
                    state.movie.genres!.forEach((element)=>genresList.add(element.name!));
                    List<String> productionCompanies=[];
                    state.movie.productionCompanies!.forEach((element)=>productionCompanies.add(element.name!));
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            EndPoints.imageBaseUrl + state.movie.posterPath!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start ,
                              children: [
                                Text(
                                  state.movie.title!,
                                  style: TextStyle(
                                    fontSize: 20.spMax,
                                    fontWeight: FontWeight.w800,
                                    // Text color for better contrast
                                  ),
                                ),
                                SizedBox(height: 20.h,),
                                Text(
                                  state.movie.overview!,
                                  style: TextStyle(
                                    fontSize: 16.spMax,
                                    fontWeight: FontWeight.w500,
                                    // Text color for better contrast
                                  ),
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,),
                                    SizedBox(width: 10.w,),
                                    Text("Release Date: ",
                                      style: TextStyle(
                                        fontSize: 16.spMax,
                                        fontWeight: FontWeight.w800,
                                        // Text color for better contrast
                                      ),),
                                    Text(state.movie.releaseDate!,
                                      style: TextStyle(
                                        fontSize: 16.spMax,
                                        fontWeight: FontWeight.w500,
                                        // Text color for better contrast
                                      ),),

                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  children: [
                                    const Icon(Icons.star,color: Colors.yellow,),
                                    SizedBox(width: 10.w,),
                                    Text("Rating: ",
                                      style: TextStyle(
                                        fontSize: 16.spMax,
                                        fontWeight: FontWeight.w800,
                                        // Text color for better contrast
                                      ),),
                                    Text(state.movie.voteAverage!.toString(),
                                      style: TextStyle(
                                        fontSize: 16.spMax,
                                        fontWeight: FontWeight.w500,
                                        // Text color for better contrast
                                      ),),

                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Genres: ",
                                          style: TextStyle(
                                            fontSize: 16.spMax,
                                            fontWeight: FontWeight.w800,
                                            // Text color for better contrast
                                          ),),
                                      ],
                                    ),
                                    ChipsWidget(genres: genresList)
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Production Companies: ",
                                          style: TextStyle(
                                            fontSize: 16.spMax,
                                            fontWeight: FontWeight.w800,
                                            // Text color for better contrast
                                          ),),
                                      ],
                                    ),
                                    ChipsWidget(genres: productionCompanies)
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Videos: ",
                                          style: TextStyle(
                                            fontSize: 16.spMax,
                                            fontWeight: FontWeight.w800,
                                            // Text color for better contrast
                                          ),),
                                      ],
                                    ),
                                    state.movieVideos.isNotEmpty?
                                    VideosCarousalView(videosList:state.movieVideos,)
                                        :Center(child: Text("Videos Not Available",style: TextStyle(fontWeight: FontWeight.bold),),)
                                  ],
                                ),
                                SizedBox(height: 20.h,)


                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },)
          );
        },
        listener: (context,state){

        });
  }
}
