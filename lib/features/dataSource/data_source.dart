

import '../../core/models/MovieDetailsResponse.dart';
import '../../core/models/movie_listing_response.dart';
import '../../core/models/movie_video_respons.dart';

abstract class IDataSource{
  Future<MovieListingResponse> fetchPopularMovies(int currentPage);

  Future<MovieListingResponse> fetchNowPlayingMovies(int currentPage);

  Future<MovieListingResponse> fetchNowTopRatedMovies(int currentPage);

  Future<MovieListingResponse> searchForMovies(int currentPage,String query);

  Future<MovieDetailsResponse> getMovieDetails(int movieId);

  Future<MovieVideoResponse> getMovieVideos(int movieId);

}