import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DonorDetailScreen extends StatelessWidget {
  final String username;
  final int userphoneNum;
  final String userramdonId;
  final String userbloodGroup;
  final String userhospitalAddress;
  final String userhomeAddress;
  final String usertimeStamp;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String userage; // Add user age
  final String useremail; // Add user email

  const DonorDetailScreen({
    required this.username,
    required this.userramdonId,
    required this.userphoneNum,
    required this.userbloodGroup,
    required this.userhospitalAddress,
    required this.userhomeAddress,
    required this.usertimeStamp,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.userage,
    required this.useremail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donor Detail ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://t4.ftcdn.net/jpg/06/81/51/81/240_F_681518121_LN4LfnyObzdsL7RPG00BQOAvp7sdv1Al.jpg'),
                      fit: BoxFit.fill),
                ),
                height: 200,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          ///Display user name
          Center(child: Text('Name: $username')),
          SizedBox(height: 15),

          Center(child: Text('Age: $userage')), // Display user age
          SizedBox(height: 15),

          ///Display user bloodGroup
          Center(child: Text('Blood Group: $userbloodGroup')),
          SizedBox(height: 15),

          ///Display user home address
          Center(child: Text('City: $userhomeAddress')),
          SizedBox(height: 15),
          Center(child: Text('Hospital: $userhospitalAddress')),
          SizedBox(height: 15),
          Center(
            child: Text('Location: $latitude, $longitude'),
          ),
          SizedBox(height: 15),
          Center(child: Text('Phone Number: +92$userphoneNum')),
          SizedBox(height: 15),
          MaterialButton(
            shape: StadiumBorder(),
            color: Colors.red,
            height: 50,
            minWidth: 50,
            onPressed: () {
              const String countryCode = '+92';
              FlutterPhoneDirectCaller.callNumber(
                '$countryCode$userphoneNum',
              );
            },
            child: const Text(
              'Call',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
