import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_cubit.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_state.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/presentation/widgets/build_intro_texts.dart';
import 'package:flutter_maps/presentation/widgets/build_next_button.dart';
import 'package:flutter_maps/presentation/widgets/build_phone_form_fild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key, this.phoneNumber,});

    String? phoneNumber;


   final GlobalKey<FormState> _phoneFormKey = GlobalKey();

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

   Widget _phoneNumberSubmittedBloc()
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
      if(state is PhoneNumberSubmited)
      {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
      }
      if(state is Error)
      {
        Navigator.pop(context);
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


   Future <void> _register (context) async
   {
    if(!_phoneFormKey.currentState!.validate())
    {
      Navigator.pop(context);
      return;
    }
    else
    {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneCubit>(context).submitPhoneNumber(phoneNumber);
    }
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _phoneFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 70.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildIntroTexts(
                  firstText: 'What is your phone number ?',
                  secondText: 'please enter your phone number to verfiy your account.',
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10,),
                BuildPhoneFormFild(
                  onSaved: (value)
                  {
                    phoneNumber = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10,),
                BuildNextButton(
                  text: 'Next',
                  onPressed: ()
                  {
                    showProgreesIndecator(context);
                    _register(context);

                  },
                  ),
                  _phoneNumberSubmittedBloc(),
              ],
            ),
          )
          ),
      ),
    );
  }
}