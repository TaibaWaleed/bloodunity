import 'package:bloodunity/contants/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UpdateBloodScreen extends StatelessWidget {
  const UpdateBloodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blood').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppUtils.customProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No blood available to Update.'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final productData = snapshot.data!.docs[index];
                TextEditingController nameController = TextEditingController();
                TextEditingController bloodGroupController =
                    TextEditingController();
                TextEditingController _ageController = TextEditingController();
                TextEditingController _phonenumberController =
                    TextEditingController();

                nameController.text = productData['Name'].toString();

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          child: Center(child: Text(productData['blood']))),
                      title: Text(productData['bloodName']),
                      subtitle: Text(productData['blood ']),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Update Blood'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: " Name",
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('Blood')
                                        .doc(productData.id)
                                        .update({
                                          'name': nameController.text,
                                        })
                                        .whenComplete(
                                            () => Navigator.pop(context))
                                        .then((value) => Fluttertoast.showToast(
                                            msg:
                                                'Updated ${nameController.text}'));
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: AppUtils.customProgressIndicator());
          }
        },
      ),
    );
  }
}
