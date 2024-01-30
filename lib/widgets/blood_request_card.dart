import 'package:bloodunity/screen/blood_user_screen/donor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class BloodRequestCard extends StatelessWidget {
  final String? userName;
  final int? userphoneNum;
  final String? userbloodGroup;
  final String? userhomeAddress;
  final String? userhospitalAddress;
  final String? usertimeStamp;
  final Function()? onTap;
  const BloodRequestCard({
    Key? key, // Added Key parameter
    this.userName,
    this.userphoneNum,
    this.userbloodGroup,
    this.userhospitalAddress,
    this.userhomeAddress,
    this.usertimeStamp,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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
                      subtitle: Text('+92${userphoneNum ?? 'N/A'}'),
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: TextButton.icon(
                            style: const ButtonStyle(),
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              const String countryCode = '+92';
                              FlutterPhoneDirectCaller.callNumber(
                                  '$countryCode$userphoneNum');
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
                              // Implement details screen navigation
                              //navigate to donor Details Screen
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DonorDetailScreen();
                              }));
                            },
                            label: const Text(
                              'See Details',
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
