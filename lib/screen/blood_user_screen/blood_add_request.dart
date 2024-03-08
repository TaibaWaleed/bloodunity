import 'dart:async';
import 'dart:math';
import 'package:bloodunity/contants/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloodunity/contants/collection_names.dart';
import 'package:bloodunity/model/blood_model/blood_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloodunity/widgets/custom_text_feild.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodunity/screen/home/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BloodAddRequestScreen extends StatefulWidget {
  const BloodAddRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodAddRequestScreen> createState() => _BloodAddRequestScreenState();
}

class _BloodAddRequestScreenState extends State<BloodAddRequestScreen> {
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _mapController = Completer();

  String _generateRandomId() {
    String userName = 'SHAHEENER';
    int randomId = Random().nextInt(10000);
    return '$userName$randomId';
  }

  Future<void> addBlood() async {
    try {
      if (globalkey.currentState!.validate()) {
        _currentPosition = await _determinePosition();

        if (_currentPosition != null) {
          await FirebaseFirestore.instance
              .collection(DataBaseCollection.bloodRequestsCollection)
              .add(
                BloodRequestModel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  displayName: _generateRandomId(),
                  age: _ageController.text,
                  bloodGroup: _bloodController.text,
                  phoneNumber: _phonenumberController.text,
                  city: _cityController.text,
                  hospital: _hospitalController.text,
                  location: _locationController.text,
                  message: _messageController.text,
                  latitude: _currentPosition!.latitude.toString(),
                  longitude: _currentPosition!.longitude.toString(),
                ).toMap(),
              )
              .then(
                  (value) => Fluttertoast.showToast(msg: 'added successfully'));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
              msg: 'Error: Unable to determine current position.');
        }
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error adding blood: $e');
    }
  }

  Position? _currentPosition;
  String _buildLocationDivText = 'No Location Selected yet!';

  Future<void> _updateLocationDiv() async {
    setState(() {
      _buildLocationDivText =
          "Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}";
      print(
          "Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}");
    });
  }

  Future<void> _determineAndGetCurrentLocation() async {
    try {
      _currentPosition = await _determinePosition();

      if (_currentPosition != null) {
        _updateLocationDiv();
        _locationController.text =
            "${_currentPosition?.latitude ?? 0.0}, ${_currentPosition?.longitude ?? 0.0}";
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      const String error =
          'Location permissions are permanently denied, we cannot request permissions.';
      return Future.error(error);
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Center(
          child: Container(
            height: size.height * 0.90,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: globalkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextField(
                        textEditingController: _bloodController,
                        prefixIcon: Icons.person,
                        hintText: ' BloodGroup',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      CustomTextField(
                        textEditingController: _ageController,
                        prefixIcon: Icons.numbers,
                        hintText: 'Age',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      CustomTextField(
                        textEditingController: _cityController,
                        prefixIcon: Icons.location_city,
                        hintText: ' City',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      CustomTextField(
                        textEditingController: _hospitalController,
                        prefixIcon: Icons.local_hospital,
                        hintText: 'Hospital',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      CustomTextField(
                        textEditingController: _phonenumberController,
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        hintText: ' PhoneNumber',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      CustomTextField(
                        textEditingController: _messageController,
                        prefixIcon: Icons.message_outlined,
                        hintText: ' Message for Donor',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field Should not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedbox(),
                      Container(
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(border: Border.all()),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: _currentPosition != null
                                ? LatLng(
                                    _currentPosition?.latitude ?? 0.0,
                                    _currentPosition?.longitude ?? 0.0,
                                  )
                                : const LatLng(
                                    AppUtils.latitude, AppUtils.longitude),
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: Set.from([
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position: LatLng(
                                _currentPosition?.latitude ?? 0.0,
                                _currentPosition?.longitude ?? 0.0,
                              ),
                              infoWindow: InfoWindow(
                                title: 'Current Location',
                              ),
                            ),
                          ]),
                        ),
                      ),
                      sizedbox(),
                      MaterialButton(
                        height: 50,
                        minWidth: 120,
                        shape: StadiumBorder(),
                        color: Colors.red,
                        child: const Text(
                          'Get Current Location',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _determineAndGetCurrentLocation();
                        },
                      ),
                      sizedbox(),
                      MaterialButton(
                          height: 50,
                          minWidth: 120,
                          shape: StadiumBorder(),
                          color: Colors.red,
                          onPressed: () async {
                            await addBlood();
                          },
                          child: Text(
                            'Add Request',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationDiv() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _currentPosition != null
          ? Center(
              child: Text(_buildLocationDivText),
            )
          : Center(
              child: ElevatedButton(
                child: const Text('Get Location'),
                onPressed: () {
                  _determineAndGetCurrentLocation();
                },
              ),
            ),
    );
  }

  SizedBox sizedbox() {
    return SizedBox(height: 10);
  }

  Future<void> _deleteBloodRequest(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection(DataBaseCollection.bloodRequestsCollection)
          .doc(documentId)
          .delete();
      Fluttertoast.showToast(msg: 'Blood request deleted successfully');
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Failed to delete blood request');
    }
  }
}
