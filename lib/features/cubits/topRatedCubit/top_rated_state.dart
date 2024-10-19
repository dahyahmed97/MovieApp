import 'package:equatable/equatable.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';

abstract class TopRatedMoviesState extends Equatable{
  @override
  List<Object?> get props => [];
}
class TopRatedMoviesInitialState extends TopRatedMoviesState{
  @override
  List<Object?> get props => [];
}
class TopRatedMoviesLoadingState extends TopRatedMoviesState{
  @override
  List<Object?> get props => [];
}
class TopRatedMoviesSuccessState extends TopRatedMoviesState{
  final List<Results> moviesList;
  TopRatedMoviesSuccessState(this.moviesList);
  @override
  List<Object?> get props => [moviesList];
}
class TopRatedMoviesErrorState extends TopRatedMoviesState{
  final String message;
  TopRatedMoviesErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
