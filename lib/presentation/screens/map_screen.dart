import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_cubit.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/presentation/widgets/build_next_button.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});


  PhoneCubit? phoneCubit = PhoneCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: BlocProvider<PhoneCubit>(
              create: (context) => phoneCubit!,
              child: BuildNextButton(
                text: 'Logout',
                onPressed: () async 
                {
                  await phoneCubit!.signOut();
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
