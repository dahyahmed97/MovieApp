import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_state.dart';
import 'package:fh_movie_app/features/repo/repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/repo.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {

  late IRepository repository;
  MovieDetailsCubit(IRepository repo) : super(MovieDetailsInitialState()){
    repository=repo;
  }

  // Method to simulate data loading
  Future<void> fetchMovieDetails(int movieId) async {
    bool  isFetchMovieSuccess=false;
    MovieDetailsResponse? movie;
    emit(MovieDetailsLoadingState());
    var res= await repository.getMovieDetails(movieId);
    res.fold((l) => {
      emit(MovieDetailsErrorState(l.message))
    }, (response) => {
      isFetchMovieSuccess=true,
      movie=response
    });
    if(isFetchMovieSuccess) {
      var res1 = await repository.getMovieVideos(movieId);
      res1.fold((l) =>
      {
        emit(MovieDetailsErrorState(l.message))
      }, (response1) =>
      {
        emit(MovieDetailsSuccessState(movie!, response1.results!))
      });
    }
  }
}