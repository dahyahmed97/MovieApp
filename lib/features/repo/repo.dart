
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/models/movie_video_respons.dart';

import '../../core/error/failures.dart';
import '../../core/models/MovieDetailsResponse.dart';
import '../../core/models/movie_listing_response.dart';
abstract class IRepository {
  Future<Either<Failure,MovieListingResponse>> fetchPopularMovies(int currentPage);

  Future<Either<Failure,MovieListingResponse>> fetchNowPlayingMovies(int currentPage);

  Future<Either<Failure,MovieListingResponse>> fetchNowTopRatedMovies(int currentPage);

  Future<Either<Failure,MovieListingResponse>> searchForMovies(int currentPage, String query);

  Future<Either<Failure,MovieDetailsResponse>> getMovieDetails(int movieId);

  Future<Either<Failure,MovieVideoResponse>> getMovieVideos(int movieId);
}
