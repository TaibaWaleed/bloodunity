import 'package:bloodunity/screen/blood_user_screen/donor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class BloodRequestCard extends StatelessWidget {
  // Existing parameters...
  final String userName;
  final int userphoneNum;
  final String userbloodGroup;
  final String userhospitalAddress;
  final String userhomeAddress;
  final String usertimeStamp;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final dynamic userAge; // Replace with actual data
  final String userEmail; // Replace with actual data
  const BloodRequestCard({
    required this.userName,
    required this.userphoneNum,
    required this.userbloodGroup,
    required this.userhospitalAddress,
    required this.userhomeAddress,
    required this.usertimeStamp,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.userAge,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {},
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: Container(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(userName ?? 'N/A'),
                      subtitle: Text('+92$userphoneNum' ?? 'N/A'),
                      trailing: Text(
                        userbloodGroup ?? 'N/A',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(userhomeAddress ?? 'N/A'),
                      trailing: Text(usertimeStamp ?? 'N/A'),
                    ),
                  ),

                  ///call button
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: TextButton.icon(
                            style: ButtonStyle(
                                // Add style properties if needed
                                ),
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              const String countryCode = '+92';
                              FlutterPhoneDirectCaller.callNumber(
                                '$countryCode$userphoneNum',
                              );
                            },
                            label: const Text(
                              'CALL',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.details,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Navigate to donor Details Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return DonorDetailScreen(
                                    // Pass the required parameters to the donor detail screen
                                    username: userName,
                                    userage: userAge,
                                    useremail: userEmail,
                                    userphoneNum: userphoneNum,
                                    userbloodGroup: userbloodGroup,
                                    userhospitalAddress: userhospitalAddress,
                                    userhomeAddress: userhomeAddress,
                                    usertimeStamp: usertimeStamp,
                                    latitude: latitude,
                                    longitude: longitude,
                                    phoneNumber: phoneNumber, userramdonId: '',
                                  );
                                }),
                              );
                            },
                            label: const Text(
                              'SEE DETAILS',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
