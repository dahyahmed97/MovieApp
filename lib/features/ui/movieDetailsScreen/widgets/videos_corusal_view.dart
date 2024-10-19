import 'package:carousel_slider/carousel_slider.dart';
import 'package:fh_movie_app/features/ui/movieDetailsScreen/widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/models/movie_video_respons.dart';

class VideosCarousalView extends StatefulWidget {
  final List<Video> videosList;
  const VideosCarousalView({super.key, required this.videosList});

  @override
  State<VideosCarousalView> createState() => _VideosCarousalViewState();
}

class _VideosCarousalViewState extends State<VideosCarousalView> {


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical:10.h),
      child:CarouselSlider.builder(
        itemCount:widget.videosList.length,
        itemBuilder: (context,index,realIndex){
          return YoutubePlayerWidget(videoKey: widget.videosList[index].key!,);
        },
        options: CarouselOptions(
          height: 280.h,
          autoPlay: false,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          autoPlayInterval: const Duration(seconds: 6),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1,
          aspectRatio: 16 / 9,
        ),),
    );
  }
}
