import 'package:flutter/material.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BuildPinCodeFields extends StatelessWidget {
   BuildPinCodeFields({super.key,required this.onCompleted});

    Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 45.h,
          fieldWidth: 35.w,
          borderWidth: 1,
          activeColor: MyColors.blue,
          inactiveColor: Colors.black,
          inactiveFillColor: Colors.white,
          activeFillColor: MyColors.lightBlue,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: onCompleted,
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}