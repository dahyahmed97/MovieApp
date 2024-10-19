import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_cubit.dart';
import 'package:fh_movie_app/features/cubits/favoritesCubit/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commonWidgets/movie_grid_item.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<FavoritesCubit, FavoriteMoviesState>(
        builder: (context, state) {
          if(state is FavoriteMoviesSuccessState){
            if(state.movieList.isNotEmpty){
              return GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 10, // Space between horizontal items
                    mainAxisSpacing: 10, // Space between vertical items
                    childAspectRatio: 1.0,
                    mainAxisExtent: 300.h
                  // Aspect ratio for grid items
                ),
                padding: EdgeInsets.all(10.h),
                itemCount: state.movieList.length, // Add an extra item for the loading indicator
                itemBuilder: (context, index) {
                  return MovieGridItem(imageUrl: state.movieList[index].posterPath!, movieId:state.movieList[index].id!,);
                },
              );
            }else{
              return Center(child: Text("No Favorite Movies Added",
              style: TextStyle(color: Colors.grey,
                  fontWeight: FontWeight.w800,fontSize: 17.spMax),),);
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
