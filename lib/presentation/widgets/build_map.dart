import 'dart:async';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_maps/helpers/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuildMap extends StatefulWidget {
  const BuildMap({super.key });

  static Completer <GoogleMapController> mapController = Completer();

  static Position? position;

  static CameraPosition myCameraPosition = CameraPosition(
    target: LatLng(position!.latitude,position!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
    );

  @override
  State<BuildMap> createState() => _BuildMapState();
}

class _BuildMapState extends State<BuildMap> {
  @override


  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: BuildMap.myCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller)
      {
       BuildMap.mapController.complete(controller);
      },
    );
  }
}