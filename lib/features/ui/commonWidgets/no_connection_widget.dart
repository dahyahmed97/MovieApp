import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text("No Favorite Movies Added",
        style: TextStyle(color: Colors.grey,
            fontWeight: FontWeight.w800,fontSize: 17.spMax),),),
    );
  }
}
