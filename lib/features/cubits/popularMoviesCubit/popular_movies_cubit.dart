import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:fh_movie_app/features/repo/repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {

  late IRepository repository;
// Prevents multiple fetches at the same time
  List<Results> movies = [];
  PopularMoviesCubit(IRepository repo): super(PopularMoviesInitialState()){
    repository=repo;
  }

  // Method to simulate data loading
  Future<void> fetchPopularMovies(int currentPage) async {
    emit(PopularMoviesLoadingState());
    var res= await repository.fetchPopularMovies(currentPage);
    res.fold((l) => {
      emit(PopularMoviesErrorState(l.message))
    }, (response) => {
      response.results!.forEach((element)=>movies.add(element)),
      emit(PopularMoviesSuccessState(movies))
    });
  }
}
