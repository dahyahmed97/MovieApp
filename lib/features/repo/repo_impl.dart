import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/models/movie_video_respons.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import '../../core/network/network_info.dart';
import '../dataSource/data_source.dart';
import '../../core/base/base_repo.dart';

class Repository extends BaseRepository implements IRepository {
 late IDataSource dataSource;

  Repository(IDataSource appDataSource) : super(NetworkInfo(con: DataConnectionChecker())){
    dataSource=appDataSource;
  }

  @override
  Future<Either<Failure, MovieListingResponse>> fetchNowPlayingMovies(int currentPage) {
    return handleException(() => dataSource.fetchNowPlayingMovies(currentPage));
  }

  @override
  Future<Either<Failure, MovieListingResponse>> fetchNowTopRatedMovies(int currentPage) {
    return handleException(() => dataSource.fetchNowTopRatedMovies(currentPage));
  }

  @override
  Future<Either<Failure, MovieListingResponse>> fetchPopularMovies(int currentPage) {
    return handleException(() => dataSource.fetchPopularMovies(currentPage));
  }

  @override
  Future<Either<Failure, MovieDetailsResponse>> getMovieDetails(int movieId) {
    return handleException(() => dataSource.getMovieDetails(movieId));
  }

  @override
  Future<Either<Failure, MovieListingResponse>> searchForMovies(int currentPage, String query) {
    return handleException(() => dataSource.searchForMovies(currentPage,query));
  }

  @override
  Future<Either<Failure, MovieVideoResponse>> getMovieVideos(int movieId) {
    return handleException(() => dataSource.getMovieVideos(movieId));
  }
  
  

}