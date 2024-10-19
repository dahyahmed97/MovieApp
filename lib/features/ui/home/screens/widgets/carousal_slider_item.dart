import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/core/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarousalSliderItem extends StatelessWidget {
  final String imageUrl;
  final String movieTitle;
  final String rating;
  final int movieId;

  const CarousalSliderItem({
    super.key,
    required this.imageUrl,
    required this.movieTitle,
    required this.rating,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(RoutesCatalog.movieDetailsScreen,arguments: movieId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(40.r),

        ),
        child: Column(
          children: [
            // Use Stack to overlay text on the image
            Stack(
              children: [
                // Image with rounded top corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: Image.network(
                    EndPoints.imageBaseUrl + imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
                // Overlay with title and rating
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6), // Semi-transparent background
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movieTitle,
                          style: TextStyle(
                            fontSize: 18.spMax,
                            fontWeight: FontWeight.w800,
                            color: Colors.white, // Text color for better contrast
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              rating,
                              style: TextStyle(
                                fontSize: 18.spMax,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
