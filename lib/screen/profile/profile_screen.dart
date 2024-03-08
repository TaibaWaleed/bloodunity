import 'dart:io';
import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/widgets/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class BloodProfileScreen extends StatefulWidget {
  const BloodProfileScreen({Key? key}) : super(key: key);

  @override
  State<BloodProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<BloodProfileScreen> {
  File? _pickedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            var user = snapshot.data!;
            return Column(
              children: [
                SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        child: InkWell(
                          onTap: () => showModalBottomSheetSuggestions(context),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: _pickedImage != null
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: FileImage(_pickedImage!),
                                  )
                                : user['photoURL'] != null
                                    ? CircleAvatar(
                                        radius: 100,
                                        backgroundImage:
                                            NetworkImage(user['photoURL']),
                                      )
                                    : const Icon(Icons.person, size: 80),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                sizedbox(),

                CustomTextField(
                  textEditingController: _nameController,
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                ),

                sizedbox(),

                CustomTextField(
                  textEditingController: _bloodGroupController,
                  hintText: 'Blood Group',
                  prefixIcon: Icons.bloodtype,
                ),

                sizedbox(),

                CustomTextField(
                  textEditingController: _ageController,
                  hintText: 'Age',
                  prefixIcon: Icons.numbers,
                  keyboardType: TextInputType.number,
                ),

                sizedbox(),

                CustomTextField(
                  textEditingController: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                sizedbox(),

                ///save button
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _updateProfile(user.id);
                  },
                ),
              ],
            );
          } else {
            return const Center(child: Text('No user data found.'));
          }
        },
      ),
    );
  }

  showModalBottomSheetSuggestions(BuildContext context) {}

  // ... (remaining code remains the same)
}

class _updateProfile {
  _updateProfile(String id);
}
