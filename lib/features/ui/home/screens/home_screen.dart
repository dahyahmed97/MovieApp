import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_cubit.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_state.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_state.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_cubit.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_state.dart';
import 'package:fh_movie_app/features/ui/home/screens/widgets/movie_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    // Refresh data by calling Cubits' fetch methods
    context.read<PopularMoviesCubit>().fetchPopularMovies(1);
    context.read<NowPlayingCubit>().fetchNowPlayingMovies(1);
    context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensures it scrolls even if content is small
          child: Column(
            children: [
              BlocConsumer<PopularMoviesCubit, PopularMoviesState>(
                listener: (context, state) {
                  if (state is PopularMoviesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PopularMoviesLoadingState) {
                    return MovieViewWidget(
                        movieList: const [],
                        sectionTitle: 'Popular Movies',
                        onSeeAllPressed: () {
                          Navigator.of(context).pushNamed(
                            RoutesCatalog.popularMoviesScreen,
                          );
                        },
                        isLoading: true);
                  } else if (state is PopularMoviesSuccessState) {
                    return MovieViewWidget(
                      movieList: state.moviesList,
                      sectionTitle: 'Popular Movies',
                      onSeeAllPressed: () {
                        Navigator.of(context).pushNamed(
                          RoutesCatalog.popularMoviesScreen,
                        );
                      },
                      isLoading: false,
                    );
                  }
                  return const SizedBox.shrink(); // Empty widget if no state matches
                },
              ),
              BlocConsumer<NowPlayingCubit, NowPlayingState>(
                listener: (context, state) {
                  if (state is NowPlayingErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NowPlayingLoadingState) {
                    return MovieViewWidget(
                      movieList:const [],
                      sectionTitle: 'Now Playing',
                      onSeeAllPressed: () {
                        Navigator.of(context).pushNamed(
                          RoutesCatalog.nowPlayingMoviesScreen,
                        );
                      }, isLoading: true,
                    );
                  } else if (state is NowPlayingSuccessState) {
                    return MovieViewWidget(
                      movieList: state.moviesList,
                      sectionTitle: 'Now Playing',
                      onSeeAllPressed: () {
                        Navigator.of(context).pushNamed(
                          RoutesCatalog.nowPlayingMoviesScreen,
                        );
                      }, isLoading: false,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocConsumer<TopRatedMoviesCubit, TopRatedMoviesState>(
                listener: (context, state) {
                  if (state is TopRatedMoviesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TopRatedMoviesLoadingState) {
                    return MovieViewWidget(
                      movieList: const [],
                      sectionTitle: 'Top Rated',
                      onSeeAllPressed: () {
                        Navigator.of(context).pushNamed(
                          RoutesCatalog.topRatedMoviesScreen,
                        );
                      }, isLoading: true,
                    );
                  } else if (state is TopRatedMoviesSuccessState) {
                    return MovieViewWidget(
                      movieList: state.moviesList,
                      sectionTitle: 'Top Rated',
                      onSeeAllPressed: () {
                        Navigator.of(context).pushNamed(
                          RoutesCatalog.topRatedMoviesScreen,
                        );
                      }, isLoading: false,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
