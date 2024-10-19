import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/movie_listing_response.dart';
import '../../../core/services/service_locator.dart';
import '../../repo/repo.dart';
import '../../repo/repo_impl.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {

  late IRepository repository;
  List<Results> movies = [];
  NowPlayingCubit(IRepository repo) : super(NowPlayingInitialState()){
    repository=repo;
  }

  // Method to simulate data loading
  Future<void> fetchNowPlayingMovies(int currentPage) async {
    emit(NowPlayingLoadingState());
    var res= await repository.fetchNowPlayingMovies(currentPage);
    res.fold((l) => {
      emit(NowPlayingErrorState(l.message))
    }, (response) => {
      response.results!.forEach((element)=>movies.add(element)),
      emit(NowPlayingSuccessState(movies))
    });
  }
}
