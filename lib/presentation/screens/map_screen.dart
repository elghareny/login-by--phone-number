import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_cubit.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/helpers/location_helper.dart';
import 'package:flutter_maps/presentation/widgets/build_next_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
   MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

   PhoneCubit? phoneCubit = PhoneCubit();

   Completer <GoogleMapController> _controller = Completer();

   static Position? position;

   static CameraPosition _myCameraPosition = CameraPosition(
    target: LatLng(position!.latitude,position!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
    );

   Future <void> getCurrentLocation()async
   {
    position = await LocationHelper.getCurrentLocation().whenComplete(() 
    {
      setState(() { });
    });
   }


   Future <void> _goToMyLocation ()async
   {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCameraPosition));
   }

   Widget buildMap ()
   {
    return GoogleMap(
      initialCameraPosition: _myCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller)
      {
        _controller.complete(controller);
      },
    );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null ? buildMap() : 
          Center(
            child: CircularProgressIndicator(color: MyColors.blue,),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyLocation,
        backgroundColor: MyColors.blue,
        child: Icon(Icons.place, color: Colors.white,),
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