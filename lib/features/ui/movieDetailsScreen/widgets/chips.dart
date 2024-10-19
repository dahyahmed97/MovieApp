import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipsWidget extends StatelessWidget {
  final List<String> genres;

  const ChipsWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Space between chips
      runSpacing: 4.0, // Space between lines of chips
      children: genres.map((genre) {
        return Chip(
          label: Text(
            genre,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.spMax,
            ),
          ),
          backgroundColor: Colors.blueAccent, // Chip background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.r), // Rounded edges
          ),
        );
      }).toList(),
    );
  }
}