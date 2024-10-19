import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/core/utils/endpoints.dart';
import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_cubit.dart';
import 'package:fh_movie_app/features/cubits/searchMoviesCubit/search_movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  String query = '';

  @override
  void initState() {
    super.initState();

    // Add a listener to the ScrollController
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Load more movies when at the bottom of the list
        if (query.isNotEmpty) {
          currentPage++;
          context.read<SearchMoviesCubit>().fetchPopularMovies(currentPage, query);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (newQuery) {

            // Reset to the first page and query
            query = newQuery;
            currentPage = 1;
            context.read<SearchMoviesCubit>().fetchPopularMovies(currentPage, query);
          },
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: OutlineInputBorder(),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
            builder: (context, state) {
              if (state is SearchMoviesLoadingState && currentPage == 1) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchMoviesSuccessState) {
                return ListView.builder(
                  controller: _scrollController, // Attach the ScrollController
                  itemCount: state.moviesList.length + (state is SearchMoviesLoadingState ? 1 : 0), // Add one for loading more
                  itemBuilder: (context, index) {
                    if (index == state.moviesList.length) {
                      return const Center(child: CircularProgressIndicator()); // Show loading indicator at the end
                    }
                    final movie = state.moviesList[index];
                    return ListTile(
                      onTap: (){
                        Navigator.of(context).pushNamed(RoutesCatalog.movieDetailsScreen
                        ,arguments: movie.id);
                      },
                      title: Text(movie.title!),
                      leading:movie.posterPath!=null && movie.posterPath!.isNotEmpty
                          ? Image.network('${EndPoints.imageBaseUrl}${movie.posterPath}')
                          : null,
                    );
                  },
                );
              } else if (state is SearchMoviesErrorState) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Search for movies'));
            },
          ),
        ),
      ],
    );
  }
}
