

import 'package:flutter/material.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildIntroTexts extends StatelessWidget {
   BuildIntroTexts({super.key , required this.firstText , required this.secondText , this.phoneNumber});

   String? firstText;
   String? secondText;
   
   late final phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(firstText!,
      style: TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),),
      SizedBox(
        height: MediaQuery.of(context).size.height / 30,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: RichText(
          text: TextSpan(text: secondText!,
          style: TextStyle(
            height: 1.1.h,
        fontSize: 16.sp,
        color: Colors.black
      ),
      children: [
        TextSpan(
          text: phoneNumber ?? '',
          style: TextStyle(
            height: 1.1.h,
        fontSize: 16.sp,
        color: MyColors.blue
      ),
        )
      ]
        ),
      ),
      )
    ],
  );
  }
}