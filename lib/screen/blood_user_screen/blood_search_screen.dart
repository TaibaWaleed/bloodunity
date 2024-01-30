import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodSearchScreen extends StatefulWidget {
  const BloodSearchScreen({Key? key}) : super(key: key);

  @override
  State<BloodSearchScreen> createState() => _BloodSearchScreenState();
}

class _BloodSearchScreenState extends State<BloodSearchScreen> {
  String selectedBloodGroup = '';
  String selectedLocation = '';

  final CollectionReference bloodRequests =
      FirebaseFirestore.instance.collection('Search_bloodGroup');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Select Blood Group:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.tint, color: Colors.red),
                  onPressed: () {
                    _showBloodGroupDialog();
                  },
                ),
                SizedBox(height: 50),
                Text(
                  selectedBloodGroup.isNotEmpty
                      ? 'Selected: $selectedBloodGroup'
                      : 'Select a Blood group',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Enter a Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              decoration: InputDecoration(hintText: 'Enter Your Location'),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitRequest();
                      },
                      child: Text('Search'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _donateBlood();
                      },
                      child: Text('Donate'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBloodGroupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Blood Group'),
          content: Column(
            children: [
              _buildBloodGroupButton('A+'),
              _buildBloodGroupButton('A-'),
              _buildBloodGroupButton('B+'),
              _buildBloodGroupButton('B-'),
              _buildBloodGroupButton('AB+'),
              _buildBloodGroupButton('AB-'),
              _buildBloodGroupButton('O+'),
              _buildBloodGroupButton('O-'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBloodGroupButton(String bloodGroup) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedBloodGroup = bloodGroup;
        });
        Navigator.pop(context);
      },
      child: Text(bloodGroup),
    );
  }

  void _submitRequest() {
    if (selectedBloodGroup.isNotEmpty && selectedLocation.isNotEmpty) {
      bloodRequests.add({
        'bloodGroup': selectedBloodGroup,
        'location': selectedLocation,
      });

      print('Blood Request Submitted');
      print('Blood Group: $selectedBloodGroup, Location: $selectedLocation');
    } else {
      print('Please select blood group and enter location');
    }
  }

  void _donateBlood() {
    // Implement your logic for blood donation
    print('Donate Button Pressed');
  }
}
