import 'package:equatable/equatable.dart';

import '../../../core/models/movie_listing_response.dart';

abstract class NowPlayingState extends Equatable{
  @override
  List<Object?> get props => [];
}
class NowPlayingInitialState extends NowPlayingState{
  @override
  List<Object?> get props => [];
}
class NowPlayingLoadingState extends NowPlayingState{
  @override
  List<Object?> get props => [];
}
class NowPlayingSuccessState extends NowPlayingState{
  final List<Results> moviesList;
  NowPlayingSuccessState(this.moviesList);
  @override
  List<Object?> get props => [moviesList];
}
class NowPlayingErrorState extends NowPlayingState{
  final String message;
  NowPlayingErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
