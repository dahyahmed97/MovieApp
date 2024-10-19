import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/movie_listing_response.dart';
import '../../../core/services/service_locator.dart';
import '../../repo/repo.dart';
import '../../repo/repo_impl.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {

  late IRepository repository;// Prevents multiple fetches at the same time
  List<Results> movies = [];
  SearchMoviesCubit(IRepository repo) : super(SearchMoviesInitialState()){
    repository=repo;
  }

  // Method to simulate data loading
  Future<void> fetchPopularMovies(int currentPage,String query) async {
    emit(SearchMoviesLoadingState());
    if(currentPage==1){
      movies=[];
    }
    var res= await repository.searchForMovies(currentPage,query);
    res.fold((l) => {
      emit(SearchMoviesErrorState(l.message))
    }, (response) => {
      response.results!.forEach((element)=>movies.add(element)),
      emit(SearchMoviesSuccessState(movies))
    });
  }
}