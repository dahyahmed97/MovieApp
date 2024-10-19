import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/movie_listing_response.dart';
import '../../../core/services/service_locator.dart';
import '../../repo/repo.dart';
import '../../repo/repo_impl.dart';
import '../popularMoviesCubit/popular_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {

 late IRepository repository;
 List<Results> movies = [];
  TopRatedMoviesCubit(IRepository repo) : super(TopRatedMoviesInitialState()){
    repository=repo;
  }

  // Method to simulate data loading
  Future<void> fetchTopRatedMovies(int currentPage) async {
    emit(TopRatedMoviesLoadingState());
    var res= await repository.fetchNowTopRatedMovies(currentPage);
    res.fold((l) => {
      emit(TopRatedMoviesErrorState(l.message))
    }, (response) => {
      response.results!.forEach((element)=>movies.add(element)),
      emit(TopRatedMoviesSuccessState(movies))
    });
  }
}