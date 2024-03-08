import 'package:bloodunity/components/carousel_slider_component.dart';
import 'package:bloodunity/contants/collection_names.dart';
import 'package:bloodunity/widgets/blood_request_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required String searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///display slider
            carouselSliderMethod(),

            ListTile(
              title: Text(
                'Donor Blood Request',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_drop_down_circle),
            ),

            // Make sure the method name is correct
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(DataBaseCollection.bloodRequestsCollection)
                  .snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  debugPrint("Snapshot Error: ${snapshot.error}");
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  var documents = snapshot.data!.docs;

                  if (documents.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  // Inside the StreamBuilder where you map through documents
                  return Column(
                    children: documents.map((document) {
                      var user = document.data() as Map<String, dynamic>;
                      final displayName = user['displayName'];
                      final bloodGroup = user['bloodGroup']?.toString() ?? '';
                      final phoneNum = user['phoneNumber'] ?? '';
                      final city = user['city']?.toString() ?? '';
                      final hospital = user['hospital']?.toString() ?? '';
                      final message = user['message']?.toString() ?? '';
                      final latitude = double.tryParse(
                              user['latitude']?.toString() ?? '0.0') ??
                          0.0;
                      final longitude = double.tryParse(
                              user['longitude']?.toString() ?? '0.0') ??
                          0.0;

                      // Placeholder for age
                      final age = user[
                          'age']; // Replace with the actual key used in Firestore for age

                      // Placeholder for email
                      final email = user['email']?.toString() ??
                          ''; // Replace with the actual key used in Firestore for email

                      return BloodRequestCard(
                        userName: displayName,
                        userAge: age,
                        userEmail: email,
                        userphoneNum: int.tryParse(phoneNum) ?? 0,
                        userbloodGroup: bloodGroup,
                        userhospitalAddress: hospital,
                        userhomeAddress: city,
                        usertimeStamp: message,
                        latitude: latitude,
                        longitude: longitude,
                        phoneNumber: phoneNum,
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
