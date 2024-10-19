import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/core/mocks/repoMocks/repository_mock.mocks.dart'; // Import the generated mock

void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockIRepository mockRepository;

  setUp(() {
    mockRepository = MockIRepository();
    popularMoviesCubit = PopularMoviesCubit(mockRepository);

  });

  tearDown(() {
    popularMoviesCubit.close();
    // Close cubit to avoid memory leaks
  });

  group('fetchPopularMovies', () {
    const currentPage = 1;
    final mockResponse = MovieListingResponse(results: []);

    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'emits [PopularMoviesLoadingState, PopularMoviesSuccessState] on success',
      build: () {
        when(mockRepository.fetchPopularMovies(currentPage))
            .thenAnswer((_) async => Right(mockResponse));
        return popularMoviesCubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(1),
      expect: () => [
        PopularMoviesLoadingState(),
        PopularMoviesSuccessState(mockResponse.results!),
      ],
    );

    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'emits [PopularMoviesLoadingState, PopularMoviesErrorState] on failure',
      build: () {
        when(mockRepository.fetchPopularMovies(currentPage))
            .thenAnswer((_) async => Left(Failure('Network error')));
        return popularMoviesCubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(currentPage),
      expect: () => [
        PopularMoviesLoadingState(),
        PopularMoviesErrorState('Network error'),
      ],
    );
  });
}
