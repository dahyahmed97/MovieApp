import 'package:equatable/equatable.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';

abstract class FavoriteMoviesState extends Equatable{
  @override
  List<Object?> get props => [];
}
class FavoriteMoviesInitialState extends FavoriteMoviesState{
  @override
  List<Object?> get props => [];
}
class FavoriteMoviesLoadingState extends FavoriteMoviesState{
  @override
  List<Object?> get props => [];
}
class FavoriteMoviesSuccessState extends FavoriteMoviesState{
  final List<MovieDetailsResponse> movieList;
  FavoriteMoviesSuccessState(this.movieList);
  @override
  List<Object?> get props => [movieList];
}
class FavoriteMoviesErrorState extends FavoriteMoviesState{
  final String message;
  FavoriteMoviesErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
