

import 'package:flutter/material.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildPhoneFormFild extends StatelessWidget {
   BuildPhoneFormFild({super.key , required this.onSaved});

    Function(String?)? onSaved;

    String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.lightGrey),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Center(
              child: Text(generateCountryFlag() +' +20',
              style: TextStyle(
          fontSize: 18.sp,
          letterSpacing: 2
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 30,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.blue),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              autofocus: true,
              style: TextStyle(
                fontSize: 18.sp,
                letterSpacing: 2
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: Colors.black,
              validator: (value)
              {
                if(value!.isEmpty)
                {
                  return 'please enter your phone number !';
                }else if(value.length < 11)
                {
                  return 'too short for a phone number';
                }
                return null;
              },
              onSaved: onSaved,
            )
          ),
        ),
      ],
    );
  }
}