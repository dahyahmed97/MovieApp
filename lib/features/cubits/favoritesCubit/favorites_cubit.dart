import 'dart:convert';

import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/preferences/preferences_manager.dart';
import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator.dart';

class FavoritesCubit extends Cubit<FavoriteMoviesState> {

  FavoritesCubit() : super(FavoriteMoviesInitialState());
  List<MovieDetailsResponse> favoriteMovies=[];

  Future<void> fetchFavoriteMovies() async {
    emit(FavoriteMoviesLoadingState());
    String? moviesJson = await sl<PreferenceManager>().getFavoriteMovies();
    if (moviesJson != null) {
      List<dynamic> moviesList = jsonDecode(moviesJson);
      favoriteMovies= moviesList.map((json) => MovieDetailsResponse.fromJson(json)).toList();
    }
    print("movies fetched");
    emit(FavoriteMoviesSuccessState(favoriteMovies));
  }

  Future<void> toggleFavoriteMovie(int movieId,
      MovieDetailsResponse currentMovie) async {
    emit(FavoriteMoviesLoadingState());
    var movie= favoriteMovies.where((element)=>element.id==movieId).toList();
    if(movie.isNotEmpty){
      favoriteMovies.remove(movie.first);
    }else{
      favoriteMovies.add(currentMovie);
    }
    String moviesJson = jsonEncode(favoriteMovies.map((m) => m.toJson()).toList());
    sl<PreferenceManager>().setFavoriteMovies(moviesJson);

    emit(FavoriteMoviesSuccessState(favoriteMovies));
  }


}