import 'package:carousel_slider/carousel_slider.dart';
import 'package:fh_movie_app/features/ui/home/screens/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/movie_listing_response.dart';
import 'carousal_slider_item.dart';

class MovieViewWidget extends StatelessWidget {
  final List<Results> movieList;
  final String sectionTitle;
  final Function() onSeeAllPressed;
  final bool isLoading;
  const MovieViewWidget({super.key, required this.movieList, required this.sectionTitle,required this.onSeeAllPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(sectionTitle,style: TextStyle(fontSize: 18.spMax,fontWeight: FontWeight.bold),),
            GestureDetector(
              onTap: onSeeAllPressed,
              child: Row(
                children: [
                  Text("See All",style: TextStyle(fontSize: 16.spMax,fontWeight: FontWeight.normal),),
                  const Icon(Icons.arrow_forward_ios),
                  SizedBox(width: 20.w,)
                ],
              ),
            ),
          ],),
        ),
        SizedBox(height: 20.h,),
        Padding(
          padding: EdgeInsets.symmetric(vertical:10.h),
          child:isLoading?const ShimmerMovieItem():CarouselSlider.builder(
            itemCount:10,
            itemBuilder: (context,index,realIndex){
              return CarousalSliderItem(imageUrl: movieList[index].posterPath!, movieTitle: movieList[index].title!,
                rating: movieList[index].voteAverage.toString(), movieId: movieList[index].id!,);
            },
            options: CarouselOptions(
              height: 710.h,
              autoPlay: true,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
              aspectRatio: 16 / 9,
            ),),
        )
      ],
    );
  }
}
