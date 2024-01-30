import 'package:flutter/material.dart';

class BloodProfileScreen extends StatefulWidget {
  @override
  _BloodProfileScreenState createState() => _BloodProfileScreenState();
}

class _BloodProfileScreenState extends State<BloodProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: bloodGroupController,
              decoration: InputDecoration(labelText: 'Blood Group'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform actions with the collected data
                print('Name: ${nameController.text}');
                print('Age: ${ageController.text}');
                print('Blood Group: ${bloodGroupController.text}');
                print('Phone Number: ${phoneNumberController.text}');
                print('Email: ${emailController.text}');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
