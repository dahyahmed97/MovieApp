import 'package:fh_movie_app/core/mocks/network/network_mock.mocks.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/utils/endpoints.dart';
import 'package:fh_movie_app/features/dataSource/data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late DataSource dataSource;
  late MockINetwork mockNetwork;

  setUp(() {
    mockNetwork = MockINetwork();
    dataSource = DataSource(mockNetwork);
  });

  group('fetchNowPlayingMovies', () {
    test('returns MovieListingResponse on success', () async {
      final mockResponse = {"results": []}; // Example JSON response

      when(mockNetwork.get('${EndPoints.nowPlaying}?page=1', auth: false))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.fetchNowPlayingMovies(1);

      expect(result, isA<MovieListingResponse>());
      expect(result.results, isEmpty);
    });
  });

  group('fetchNowTopRatedMovies', () {
    test('returns MovieListingResponse on success', () async {
      final mockResponse = {"results": []};

      when(mockNetwork.get('${EndPoints.topRated}?page=1', auth: false))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.fetchNowTopRatedMovies(1);

      expect(result, isA<MovieListingResponse>());
    });
  });

  group('fetchPopularMovies', () {
    test('returns MovieListingResponse on success', () async {
      final mockResponse = {"results": []};

      when(mockNetwork.get('${EndPoints.popularMovies}?page=1', auth: false))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.fetchPopularMovies(1);

      expect(result, isA<MovieListingResponse>());
      expect(result.results, isEmpty);
    });
  });

  group('searchForMovies', () {
    test('returns MovieListingResponse on success', () async {
      final mockResponse = {"results": []};

      when(mockNetwork.get('${EndPoints.searchMovie}?query=batman&page=1',
          auth: false))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.searchForMovies(1, 'batman');

      expect(result, isA<MovieListingResponse>());
    });
  });

  group('getMovieDetails', () {
    test('returns MovieDetailsResponse on success', () async {
      final mockResponse = {"id": 123, "title": "Inception"};

      when(mockNetwork.get('${EndPoints.movieDetails}123', auth: false))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getMovieDetails(123);

      expect(result, isA<MovieDetailsResponse>());
      expect(result.id, 123);
      expect(result.title, 'Inception');
    });
  });
}
