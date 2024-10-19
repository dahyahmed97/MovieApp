import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fh_movie_app/core/error/failures.dart';
import 'package:fh_movie_app/core/models/movie_listing_response.dart';
import 'package:fh_movie_app/core/services/service_locator.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_cubit.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_state.dart';
import 'package:fh_movie_app/features/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/core/mocks/repoMocks/repository_mock.mocks.dart'; // Generated mocks

void main() {
  late NowPlayingCubit nowPlayingCubit;
  late MockIRepository mockRepository;

  setUp(() {
    mockRepository = MockIRepository();
    nowPlayingCubit = NowPlayingCubit(mockRepository);

  });

  tearDown(() {
    nowPlayingCubit.close();
  });

  group('fetchPopularMovies', () {
    final mockResponse = MovieListingResponse(results: []);

    blocTest<NowPlayingCubit, NowPlayingState>(
      'emits [NowPlayingLoadingState, NowPlayingSuccessState] when fetch is successful',
      build: () {
        when(mockRepository.fetchNowPlayingMovies(1))
            .thenAnswer((_) async => Right(mockResponse));
        return nowPlayingCubit;
      },
      act: (cubit) => cubit.fetchNowPlayingMovies(1),
      expect: () => [
        NowPlayingLoadingState(),
        NowPlayingSuccessState(mockResponse.results!),
      ],
    );

    blocTest<NowPlayingCubit, NowPlayingState>(
      'emits [NowPlayingLoadingState, NowPlayingErrorState] when fetch fails',
      build: () {
        when(mockRepository.fetchNowPlayingMovies(1))
            .thenAnswer((_) async => Left(Failure('Network error')));
        return nowPlayingCubit;
      },
      act: (cubit) => cubit.fetchNowPlayingMovies(1),
      expect: () => [
        NowPlayingLoadingState(),
        NowPlayingErrorState('Network error'),
      ],
    );
  });
}
