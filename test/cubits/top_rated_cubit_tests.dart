import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/mocks/repoMocks/repository_mock.mocks.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_cubit.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart'; // Import GetIt

void main() {

  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockIRepository mockRepository;

  setUp(() {
    mockRepository = MockIRepository();

    // Register the mock repository with GetIt

    topRatedMoviesCubit = TopRatedMoviesCubit(mockRepository);
  });

  tearDown(() {
    topRatedMoviesCubit.close();
   // Clear GetIt after each test
  });

  group('fetchPopularMovies', () {
    const currentPage = 1;
    final mockResponse = MovieListingResponse(results: []);

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'emits [TopRatedMoviesLoadingState, TopRatedMoviesSuccessState] on success',
      build: () {
        // Stub the fetchNowTopRatedMovies method to return a Right response
        when(mockRepository.fetchNowTopRatedMovies(currentPage))
            .thenAnswer((_) async => Right(mockResponse));
        return topRatedMoviesCubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovies(currentPage),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesSuccessState(mockResponse.results!),
      ],
    );

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'emits [TopRatedMoviesLoadingState, TopRatedMoviesErrorState] on failure',
      build: () {
        // Stub the fetchNowTopRatedMovies method to return a Left failure
        when(mockRepository.fetchNowTopRatedMovies(currentPage))
            .thenAnswer((_) async => Left(Failure('Network error')));
        return topRatedMoviesCubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovies(currentPage),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesErrorState('Network error'),
      ],
    );
  });
}
