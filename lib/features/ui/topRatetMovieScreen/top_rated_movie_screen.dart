import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_cubit.dart';
import 'package:fh_movie_app/features/cubits/topRatedCubit/top_rated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commonWidgets/movie_grid_item.dart';

class TopRatedMovieScreen extends StatefulWidget {
  const TopRatedMovieScreen({super.key});

  @override
  State<TopRatedMovieScreen> createState() => _TopRatedMovieScreenState();
}

class _TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();



    _scrollController.addListener(() {
      // When the user scrolls to the bottom, load more movies
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        currentPage++;
        context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Top Rated Movies"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
        builder: (context, state) {
          final movies = context.watch<TopRatedMoviesCubit>().movies;

          if (state is TopRatedMoviesLoadingState && movies.isEmpty) {
            // Show loading indicator when fetching initial data
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopRatedMoviesSuccessState || (state is TopRatedMoviesLoadingState && movies.isNotEmpty)) {
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
              itemCount: movies.length + (state is TopRatedMoviesLoadingState ? 1 : 0), // Add an extra item for the loading indicator
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
