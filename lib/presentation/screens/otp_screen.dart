import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/presentation/widgets/build_intro_texts.dart';
import 'package:flutter_maps/presentation/widgets/build_next_button.dart';
import 'package:flutter_maps/presentation/widgets/build_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phone_auth/phone_cubit.dart';
import '../../business_logic/cubit/phone_auth/phone_state.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key ,required this.phoneNumber});

  final phoneNumber;
   String? otpCode;


   void showProgreesIndecator(context)
   {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context, 
    builder: (context) {
      return alertDialog;
    },
    );
   }


  Widget _phoneVerficationBloc()
   {
    return BlocListener<PhoneCubit,PhoneState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
    listener: (context, state) {
      if(state is Loading)
      {
        showProgreesIndecator(context);
      }
      if(state is PhoneOTPVerifiyed)
      {
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(mapScreen);
      }
      if(state is Error)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((state).error.toString()),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
            ),
        );
      }
    },
    child: Container(),
    );
   }


   void _login(context)
   {
    BlocProvider.of<PhoneCubit>(context).submitOTP(otpCode);
   }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildIntroTexts(
                firstText: 'Verify your phone number.',
                secondText: 'Enter your 6 digit code numbers send to .',
                phoneNumber: phoneNumber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              BuildPinCodeFields(
                onCompleted: (value)
                {
                  otpCode = value;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              BuildNextButton(
                text: 'Verify',
                onPressed: ()
                {
                  showProgreesIndecator(context);

                  _login(context);
                },
                ),
                _phoneVerficationBloc(),
            ],
          ),
        ),
      ),
    );
  }
}
