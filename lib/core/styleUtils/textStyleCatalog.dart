import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colorCatalog.dart';

abstract class TextStyleCatalog{

    static TextStyle titleTextStyle=TextStyle(
        color:ColorsCatalog.whiteTextColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
        height: 0,
    );
    static TextStyle buttonTextStyle=TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 0,
    );

    static TextStyle smallTitleStyle=TextStyle(
    color:ColorsCatalog.whiteTextColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    height: 0,
    );
    static TextStyle smallLabelStyle=TextStyle(
        color:ColorsCatalog.whiteTextColor,
        fontSize: 12.sp,
        fontFamily: 'Bahij TheSansArabic',
        fontWeight: FontWeight.w500,
    );

}