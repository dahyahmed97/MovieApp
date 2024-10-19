import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/models/movie_video_respons.dart';
import '../../core/network/network.dart';
import '../../core/utils/endpoints.dart';
import 'data_source.dart';

class DataSource extends IDataSource{

  final INetwork _network;
  DataSource(this._network);

  @override
  Future<MovieListingResponse> fetchNowPlayingMovies(int currentPage) async {
    var res = await _network.get("${EndPoints.nowPlaying}?page=$currentPage&api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieListingResponse.fromJson(res);
  }

  @override
  Future<MovieListingResponse> fetchNowTopRatedMovies(int currentPage) async {
    var res = await _network.get("${EndPoints.topRated}?page=$currentPage&api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieListingResponse.fromJson(res);
  }

  @override
  Future<MovieListingResponse> fetchPopularMovies(int currentPage) async {
    var res = await _network.get("${EndPoints.popularMovies}?page=$currentPage&api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieListingResponse.fromJson(res);
  }

  @override
  Future<MovieListingResponse> searchForMovies(int currentPage, String query) async {
    var res = await _network.get("${EndPoints.searchMovie}?query=$query"
        "&page=$currentPage&api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieListingResponse.fromJson(res);
  }

  @override
  Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    var res = await _network.get("${EndPoints.movieDetails}$movieId?api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieDetailsResponse.fromJson(res);
  }

  @override
  Future<MovieVideoResponse> getMovieVideos(int movieId) async {
    var res = await _network.get("${EndPoints.movieDetails}$movieId/videos?api_key=97f7ea93fb7d01ff287291d37c469502",
        auth: false);
    return MovieVideoResponse.fromJson(res);
  }


}