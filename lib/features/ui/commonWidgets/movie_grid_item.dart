import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/core/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieGridItem extends StatelessWidget {
  final String imageUrl;
  final int movieId;
  const MovieGridItem({super.key, required this.imageUrl,
    required this.movieId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(RoutesCatalog.movieDetailsScreen,arguments: movieId);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height * 0.2, // Changed to 0.2 (20% height)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r) ,
          image: DecorationImage(
            image: NetworkImage(EndPoints.imageBaseUrl+imageUrl),
            fit: BoxFit.cover, // This will ensure the image covers the container
          ),
        ),
      ),
    );
  }
}
