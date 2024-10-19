import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_cubit.dart';
import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/core/mocks/repoMocks/repository_mock.mocks.dart'; // Import generated mock

void main() {
  late SearchMoviesCubit searchMoviesCubit;
  late MockIRepository mockRepository;

  setUp(() {
    mockRepository = MockIRepository();
    searchMoviesCubit = SearchMoviesCubit(mockRepository);
     // Inject the mock repository
  });

  tearDown(() {
    searchMoviesCubit.close(); // Close the cubit to avoid memory leaks

  });

  group('fetchPopularMovies', () {
    const currentPage = 1;
    const query = 'Inception';
    final mockResponse = MovieListingResponse(results: []);

    blocTest<SearchMoviesCubit, SearchMoviesState>(
      'emits [SearchMoviesLoadingState, SearchMoviesSuccessState] on success',
      build: () {
        when(mockRepository.searchForMovies(currentPage, query))
            .thenAnswer((_) async => Right(mockResponse));
        return searchMoviesCubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(currentPage, query),
      expect: () => [
        SearchMoviesLoadingState(),
        SearchMoviesSuccessState(mockResponse.results!),
      ],
    );

    blocTest<SearchMoviesCubit, SearchMoviesState>(
      'emits [SearchMoviesLoadingState, SearchMoviesErrorState] on failure',
      build: () {
        when(mockRepository.searchForMovies(currentPage, query))
            .thenAnswer((_) async => Left(Failure('Network error')));
        return searchMoviesCubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(currentPage, query),
      expect: () => [
        SearchMoviesLoadingState(),
        SearchMoviesErrorState('Network error'),
      ],
    );
  });
}
