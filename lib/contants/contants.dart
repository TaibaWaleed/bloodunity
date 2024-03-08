import 'package:flutter/material.dart';

class AppUtils {
  ///bold text method
  static TextStyle textBold() => const TextStyle(fontWeight: FontWeight.bold);

  ///CircularProgressIndicator
  static Center customProgressIndicator() => const Center(
          child: CircularProgressIndicator(
        color: Colors.red,
        backgroundColor: Colors.white,
      ));

  /// static TextStyle animationStyle() {
  static TextStyle animationStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
  }

  ///where we show profile info
  ///like name,email etc
  static Card profileCard(
    IconData leadingIcon,
    String title,
  ) {
    return Card(
        child: ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
    ));
  }

  ///latitude longitude
  static const double latitude = 30.123123;
  static const double longitude = 30.123123;

  static userProfileCard(IconData icon, String text) {}
}

_BloodProfileScreenState() {}

class _displayNameController {}

///not added in class to access quickly
SizedBox sizedbox() => const SizedBox(height: 10);

///not added in class to access quickly
navigateTo(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return nextScreen;
  }));
}
