import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildNextButton extends StatelessWidget {
   BuildNextButton({super.key , required this.text , this.onPressed});

   String? text;
   Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text!,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100.w, 40.h),
          primary: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
        ),
      ),
    );
  }
}