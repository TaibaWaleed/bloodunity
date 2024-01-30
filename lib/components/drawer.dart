import 'package:bloodunity/screen/crud/update_blood_screen.dart';
import 'package:bloodunity/screen/profile/profile_screen.dart';
import 'package:bloodunity/screen/review_screen/review_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Components {
  static Drawer drawerComponent(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2wNu-ab4fTO54dhxk-dqef15iV3NEfHP6Ag&usqp=CAU'),
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Text('WELCOME TO BLOOD UNITY',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),

          ///Navigator to the  Profile Screen

          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BloodProfileScreen();
            }));
          }, Icons.person, 'View Profile'),

          // Sign out user and navigate to the LogInScreen
        ],
      ),
    );
  }

// Create a common list tile component used in the drawer
  static Widget _listTileComponent(
    BuildContext context,
    void Function()? onTap,
    IconData leadingIcon,
    String title,
  ) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(leadingIcon),
          title: Text(title),
          trailing: const Icon(Icons.forward_outlined),
        ),
      ],
    );
  }
}
