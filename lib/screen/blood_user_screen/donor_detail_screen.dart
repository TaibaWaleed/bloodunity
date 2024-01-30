import 'package:flutter/material.dart';

class DonorDetailScreen extends StatelessWidget {
  const DonorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DonorDetailScreen'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(child: Text('Profile Pic')),
          SizedBox(height: 10),
          Center(child: Text('Name: person')),
          SizedBox(height: 10),
          Center(child: Text('Age: 20')),
          SizedBox(height: 10),
          Center(child: Text('Blood Group: O+')),
          SizedBox(height: 10),
          Center(child: Text('Phone Number: +1234567890')),
          SizedBox(height: 10),
          Center(child: Text('Email: john.doe@example.com')),
          SizedBox(height: 10),
          Center(child: Text('City: Anytown')),
          SizedBox(height: 10),
          Center(child: Text('Hospital: XYZ Hospital')),
          SizedBox(height: 10),
          Center(child: Text('Location: Street, City')),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add functionality for the call button
            },
            child: const Text('Call'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add functionality for the second button
            },
            child: Text("Additional Action"),
          ),
        ],
      ),
    );
  }
}
