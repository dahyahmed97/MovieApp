import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_cubit.dart';
import 'package:fh_movie_app/features/cubits/fetchNowPlayingCubit/now_playing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commonWidgets/movie_grid_item.dart';

class NowPlayingMoviesScreen extends StatefulWidget {
  const NowPlayingMoviesScreen({super.key});

  @override
  State<NowPlayingMoviesScreen> createState() => _NowPlayingMoviesScreenState();
}

class _NowPlayingMoviesScreenState extends State<NowPlayingMoviesScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();



    _scrollController.addListener(() {
      // When the user scrolls to the bottom, load more movies
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        currentPage++;
        context.read<NowPlayingCubit>().fetchNowPlayingMovies(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Now Playing Movies"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<NowPlayingCubit, NowPlayingState>(
        builder: (context, state) {
          final movies = context.watch<NowPlayingCubit>().movies;

          if (state is NowPlayingLoadingState && movies.isEmpty) {
            // Show loading indicator when fetching initial data
            return const Center(child: CircularProgressIndicator());
          } else if (state is NowPlayingSuccessState || (state is NowPlayingLoadingState && movies.isNotEmpty)) {
            // Display the grid of movies with pagination
            return GridView.builder(
              controller: _scrollController, // Keep scroll position
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10, // Space between horizontal items
                  mainAxisSpacing: 10, // Space between vertical items
                  childAspectRatio: 1.0,
                  mainAxisExtent: 300.h
                // Aspect ratio for grid items
              ),
              padding: EdgeInsets.all(10.h),
              itemCount: movies.length + (state is NowPlayingLoadingState ? 1 : 0), // Add an extra item for the loading indicator
              itemBuilder: (context, index) {
                if (index < movies.length) {
                  final movie = movies[index];
                  // Build your movie item widget here (example container)
                  return MovieGridItem(imageUrl: movie.posterPath!, movieId: movie.id!,);
                } else {
                  // Show loading indicator at the bottom of the grid
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
          return const Center(child: Text('No movies available')); // If no movies or an error occurs
        },
      ),
    );
  }
}
