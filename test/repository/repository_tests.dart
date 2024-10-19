import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/features/repo/repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fh_movie_app/core/mocks/dataSourceMocks/data_source_mocks.mocks.dart';

void main() {
  late Repository repository;
  late MockIDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockIDataSource();
    repository = Repository(mockDataSource);
  });

  group('fetchNowPlayingMovies', () {
    test('returns Right<MovieListingResponse> on success', () async {
      final mockResponse = MovieListingResponse(results: []);

      when(mockDataSource.fetchNowPlayingMovies(1))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.fetchNowPlayingMovies(1);

      expect(result, isA<Right<Failure, MovieListingResponse>>());
      expect(result.getOrElse(() => MovieListingResponse(results: [])).results, isEmpty);
    });

    test('returns Left<Failure, MovieListingResponse> on error', () async {
      when(mockDataSource.fetchNowPlayingMovies(1))
          .thenThrow(Exception('Network error'));

      final result = await repository.fetchNowPlayingMovies(1);

      expect(result, isA<Left<Failure, MovieListingResponse>>());
    });
  });

  group('fetchNowTopRatedMovies', () {
    test('returns Right<MovieListingResponse> on success', () async {
      final mockResponse = MovieListingResponse(results: []);

      when(mockDataSource.fetchNowTopRatedMovies(1))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.fetchNowTopRatedMovies(1);

      expect(result, isA<Right<Failure, MovieListingResponse>>());
    });

    test('returns Left<Failure, MovieListingResponse> on error', () async {
      when(mockDataSource.fetchNowTopRatedMovies(1))
          .thenThrow(Exception('Network error'));

      final result = await repository.fetchNowTopRatedMovies(1);

      expect(result, isA<Left<Failure, MovieListingResponse>>());
    });
  });

  group('fetchPopularMovies', () {
    test('returns Right<MovieListingResponse> on success', () async {
      final mockResponse = MovieListingResponse(results: []);

      when(mockDataSource.fetchPopularMovies(1))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.fetchPopularMovies(1);

      expect(result, isA<Right<Failure, MovieListingResponse>>());
    });
  });

  group('getMovieDetails', () {
    test('returns Right<MovieDetailsResponse> on success', () async {
      final mockResponse = MovieDetailsResponse(id: 123, title: 'Inception');

      when(mockDataSource.getMovieDetails(123))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.getMovieDetails(123);

      expect(result, isA<Right<Failure, MovieDetailsResponse>>());
      expect(result.getOrElse(() => MovieDetailsResponse(id: 0)).id, 123);
    });

    test('returns Left<Failure, MovieDetailsResponse> on error', () async {
      when(mockDataSource.getMovieDetails(123))
          .thenThrow(Exception('Network error'));

      final result = await repository.getMovieDetails(123);

      expect(result, isA<Left<Failure, MovieDetailsResponse>>());
    });
  });

  group('searchForMovies', () {
    test('returns Right<MovieListingResponse> on success', () async {
      final mockResponse = MovieListingResponse(results: []);

      when(mockDataSource.searchForMovies(1, 'batman'))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.searchForMovies(1, 'batman');

      expect(result, isA<Right<Failure, MovieListingResponse>>());
    });
  });
}
