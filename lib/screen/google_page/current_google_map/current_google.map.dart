import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloodunity/contants/contants.dart';

class CurrentGoogleMap extends StatelessWidget {
  const CurrentGoogleMap({Key? key}) : super(key: key);

  // Use a default location or get it from somewhere
  final double defaultLatitude = AppUtils.latitude;
  final double defaultLongitude = AppUtils.longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CurrentGoogleMap'),
      ),
      body: Container(
        height: 200,
        width: 500,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(defaultLatitude, defaultLongitude),
          ),
          markers: Set<Marker>.from([
            Marker(
              markerId: MarkerId('defaultLocation'),
              position: LatLng(defaultLatitude, defaultLongitude),
              infoWindow: InfoWindow(
                title: 'Default Location',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
