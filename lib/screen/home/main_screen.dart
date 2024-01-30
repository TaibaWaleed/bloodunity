import 'package:bloodunity/components/carousel_slider_component.dart';
import 'package:bloodunity/contants/collection_names.dart';
import 'package:bloodunity/widgets/blood_request_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            carouselSliderComponent(),
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
                  return Column(
                    children: documents.map((document) {
                      var user = document.data() as Map<String, dynamic>;
                      final displayName = user['displayName'];
                      final bloodGroup = user['bloodGroup']?.toString() ?? '';
                      final phoneNum = user['phoneNumber'];
                      final city = user['city']?.toString() ?? '';
                      final hospital = user['hospital']?.toString() ?? '';
                      final message = user['message']?.toString() ?? '';

                      return BloodRequestCard(
                        userName: displayName,
                        userphoneNum: int.parse(phoneNum),
                        userbloodGroup: bloodGroup,
                        userhospitalAddress: hospital,
                        userhomeAddress: city,
                        usertimeStamp: message,
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
