import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_cubit.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/helpers/location_helper.dart';
import 'package:flutter_maps/presentation/widgets/build_map.dart';
import 'package:flutter_maps/presentation/widgets/build_next_button.dart';
import 'package:flutter_maps/presentation/widgets/build_search.dart';
import 'package:flutter_maps/presentation/widgets/my_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';


class MapScreen extends StatefulWidget {
   MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

   PhoneCubit? phoneCubit = PhoneCubit();
   @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

Future <void> getCurrentLocation()async
   {
    BuildMap.position = await LocationHelper.getCurrentLocation().whenComplete(() 
    {
      setState(() { });
    });
   }

   Future <void> _goToMyLocation ()async
   {
    final GoogleMapController controller = await BuildMap.mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(BuildMap.myCameraPosition));
   }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            BuildMap.position != null ? BuildMap() : 
            Center(
              child: CircularProgressIndicator(color: MyColors.blue,),
            ),
            BuildSearch(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _goToMyLocation,
          backgroundColor: MyColors.blue,
          child: Icon(Icons.place, color: Colors.white,),
        ),
      ),
    );
  }
}









// Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             child: BlocProvider<PhoneCubit>(
//               create: (context) => phoneCubit!,
//               child: BuildNextButton(
//                 text: 'Logout',
//                 onPressed: () async 
//                 {
//                   await phoneCubit!.signOut();
//                   Navigator.of(context).pushReplacementNamed(loginScreen);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );