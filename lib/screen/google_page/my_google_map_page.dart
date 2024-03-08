import 'dart:async';
import 'package:bloodunity/contants/contants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMapPage extends StatefulWidget {
  const MyGoogleMapPage({Key? key}) : super(key: key);

  @override
  State<MyGoogleMapPage> createState() => _MyGoogleMapPageState();
}

class _MyGoogleMapPageState extends State<MyGoogleMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kSahiwal = CameraPosition(
    target: LatLng(30.666121, 73.102013),
    zoom: 14.4746,
  );

  // Define the marker as a constant to keep it fixed
  static final Marker _fixedMarker = Marker(
    markerId: MarkerId('fixedMarker'),
    position: LatLng(30.6510, 73.1394),
    infoWindow: InfoWindow(
      title: 'Fixed Marker',
      snippet: 'This is a fixed marker',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    draggable: true, // Set draggable to true to make the marker draggable
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          mapType: MapType.hybrid,
          initialCameraPosition: _kSahiwal,
          markers: {_fixedMarker},
        ),
      ),
    );
  }
}
