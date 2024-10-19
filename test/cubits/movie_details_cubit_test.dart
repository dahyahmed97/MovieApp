import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/MovieDetailsResponse.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_cubit.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/core/mocks/repoMocks/repository_mock.mocks.dart'; // Import generated mock

void main() {
  late MovieDetailsCubit movieDetailsCubit;
  late MockIRepository mockRepository;

  setUp(() {
    mockRepository = MockIRepository();

    movieDetailsCubit = MovieDetailsCubit(mockRepository);// Inject mock repository
  });

  tearDown(() {
    movieDetailsCubit.close();

  });

  group('fetchPopularMovies', () {
    const movieId = 123;
    final mockResponse = MovieDetailsResponse(id: movieId, title: 'Inception');

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'emits [MovieDetailsLoadingState, MovieDetailsSuccessState] when fetch is successful',
      build: () {
        when(mockRepository.getMovieDetails(movieId))
            .thenAnswer((_) async => Right(mockResponse));
        return movieDetailsCubit;
      },
      act: (cubit) => cubit.fetchMovieDetails(movieId),
      expect: () => [
        MovieDetailsLoadingState(),
        MovieDetailsSuccessState(mockResponse,[]),
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'emits [MovieDetailsLoadingState, MovieDetailsErrorState] when fetch fails',
      build: () {
        when(mockRepository.getMovieDetails(movieId))
            .thenAnswer((_) async => Left(Failure('Network error')));
        return movieDetailsCubit;
      },
      act: (cubit) => cubit.fetchMovieDetails(movieId),
      expect: () => [
        MovieDetailsLoadingState(),
        MovieDetailsErrorState('Network error'),
      ],
    );
  });
}
