import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RateAppScreen extends StatelessWidget {
  final CollectionReference ratingsCollection =
      FirebaseFirestore.instance.collection('app_ratings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rate App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/premium-vector/3d-blood-type-b-o-ab-red-symbol-icon-vector-isolated-white-background-3d-blood-donation-medical-healthcare-concept-cartoon-minimal-style-3d-icon-vector-render-illustration_726846-5858.jpg',
              ),
            ),
            Text(
              'How would you rate the Blood App?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 50,
              itemBuilder: (context, _) => Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onRatingUpdate: (rating) {
                // Handle the rating update
                print("User's rating: $rating");
                // You can save the rating or perform other actions here
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get the user's rating
                double userRating =
                    3; // You can replace this with the actual user's rating

                // Add the rating to Firestore
                await ratingsCollection.add({
                  'rating': userRating,
                  'timestamp': FieldValue.serverTimestamp(),
                });

                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
