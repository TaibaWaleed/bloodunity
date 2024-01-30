import 'package:bloodunity/widgets/custom_button.dart';
import 'package:bloodunity/widgets/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController viewController = TextEditingController();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: isSaving
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('reviews')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, dynamic index) {
                            final value = snapshot.data!.docs[index];

                            final location = value['location'];
                            final views = value['views'];

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                elevation: 10,
                                child: ListTile(
                                  title: Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(views),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showDialogBox(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Review Your BloodGroup"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CustomTextField(
                    hintText: 'Name',
                    textEditingController: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CustomTextField(
                    hintText: 'Enter descripiton',
                    textEditingController: descriptionController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CustomTextField(
                    hintText: 'Enter location',
                    textEditingController: locationController,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            CustomButton(
              title: "SAVE",
              onPressed: () {
                saveReview();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveReview() async {
    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'location': locationController.text,
        'name': nameController.text,
        'description': descriptionController.text,
      });

      setState(() {
        isSaving = false;
        Fluttertoast.showToast(msg: 'Review uploaded successfully');
      });
    } catch (e) {
      setState(() {
        isSaving = false;
        Fluttertoast.showToast(msg: 'Failed to upload review');
      });
    }
  }
}
