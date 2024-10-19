import 'package:equatable/equatable.dart';

import '../../../core/models/movie_listing_response.dart';

abstract class SearchMoviesState extends Equatable{
  @override
  List<Object?> get props => [];
}
class SearchMoviesInitialState extends SearchMoviesState{
  @override
  List<Object?> get props => [];
}
class SearchMoviesLoadingState extends SearchMoviesState{
  @override
  List<Object?> get props => [];
}
class SearchMoviesSuccessState extends SearchMoviesState{
  final List<Results> moviesList;
  SearchMoviesSuccessState(this.moviesList);
  @override
  List<Object?> get props => [moviesList];
}
class SearchMoviesErrorState extends SearchMoviesState{
  final String message;
  SearchMoviesErrorState(this.message);
  @override
  List<Object?> get props => [message];
}