import 'package:equatable/equatable.dart';

import '../../../core/models/movie_listing_response.dart';

abstract class PopularMoviesState extends Equatable{
  @override
  List<Object?> get props => [];
}
class PopularMoviesInitialState extends PopularMoviesState{
  @override
  List<Object?> get props => [];
}
class PopularMoviesLoadingState extends PopularMoviesState{
  @override
  List<Object?> get props => [];
}
class PopularMoviesSuccessState extends PopularMoviesState{
  final List<Results> moviesList;
   PopularMoviesSuccessState(this.moviesList);
  @override
  List<Object?> get props => [moviesList];
}
class PopularMoviesErrorState extends PopularMoviesState{
  final String message;
  PopularMoviesErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
