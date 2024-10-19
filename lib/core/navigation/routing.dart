import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_cubit.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_cubit.dart';
import 'package:fh_movie_app/features/cubits/movieDetailsCubit/movie_details_cubit.dart';
import 'package:fh_movie_app/features/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_cubit.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_cubit.dart';
import 'package:fh_movie_app/features/repo/repo_impl.dart';
import 'package:fh_movie_app/features/ui/movieDetailsScreen/movie_details_screen.dart';
import 'package:fh_movie_app/features/ui/nowPlayingMoviesScreen/now_playing_movies_screen.dart';
import 'package:fh_movie_app/features/ui/popularMoviesScreen/popular_movies_screen.dart';
import 'package:fh_movie_app/features/ui/topRatetMovieScreen/top_rated_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/ui/home/cubit/tabs_cubit.dart';
import '../../features/ui/home/screens/home_tabs_screen.dart';
import '../services/service_locator.dart';


class AppRouter {

  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    //showLog("navigation", settings.name);

    if (settings.name != '/') {
      // FBAnalytics().sendScreen(settings.name);
    }
    FavoritesCubit favoritesCubit=FavoritesCubit();

    switch (settings.name) {
      case RoutesCatalog.homeScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<TabCubit>(
                  create: (BuildContext context) => TabCubit()),
              BlocProvider<PopularMoviesCubit>(
                  create: (BuildContext context) => PopularMoviesCubit(sl<Repository>())..fetchPopularMovies(1)),
              BlocProvider<NowPlayingCubit>(
                  create: (BuildContext context) => NowPlayingCubit(sl<Repository>())..fetchNowPlayingMovies(1)),
              BlocProvider<TopRatedMoviesCubit>(
                  create: (BuildContext context) => TopRatedMoviesCubit(sl<Repository>())..fetchTopRatedMovies(1)),
              BlocProvider<SearchMoviesCubit>(
                  create: (BuildContext context) => SearchMoviesCubit(sl<Repository>())
              ),

            ],
                child:  HomeTabsScreen()));
      case RoutesCatalog.movieDetailsScreen:
        int movieId= settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<MovieDetailsCubit>(
                  create: (BuildContext context) => MovieDetailsCubit(sl<Repository>())..fetchMovieDetails(movieId)),

            ],
                child:   MovieDetailsScreen(movieId: movieId,)));
      case RoutesCatalog.popularMoviesScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<PopularMoviesCubit>(
                  create: (BuildContext context) => PopularMoviesCubit(sl<Repository>())..fetchPopularMovies(1)),
            ],
                child:  const PopularMoviesScreen()));
      case RoutesCatalog.nowPlayingMoviesScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<NowPlayingCubit>(
                  create: (BuildContext context) => NowPlayingCubit(sl<Repository>())..fetchNowPlayingMovies(1)),
            ],
                child:  const NowPlayingMoviesScreen()));
      case RoutesCatalog.topRatedMoviesScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<TopRatedMoviesCubit>(
                  create: (BuildContext context) => TopRatedMoviesCubit(sl<Repository>())..fetchTopRatedMovies(1)),
            ],
                child:  const TopRatedMovieScreen()));
    }
    return null;
  }
}
