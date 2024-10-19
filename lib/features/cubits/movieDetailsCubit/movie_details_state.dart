import 'package:equatable/equatable.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import '../../../core/models/movie_listing_response.dart';
import '../../../core/models/movie_video_respons.dart';

abstract class MovieDetailsState extends Equatable{
  @override
  List<Object?> get props => [];
}
class MovieDetailsInitialState extends MovieDetailsState{
  @override
  List<Object?> get props => [];
}
class MovieDetailsLoadingState extends MovieDetailsState{
  @override
  List<Object?> get props => [];
}
class MovieDetailsSuccessState extends MovieDetailsState{
  final MovieDetailsResponse movie;
  final List<Video> movieVideos;
  MovieDetailsSuccessState(this.movie, this.movieVideos);
  @override
  List<Object?> get props => [movie];
}
class MovieDetailsErrorState extends MovieDetailsState{
  final String message;
  MovieDetailsErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
