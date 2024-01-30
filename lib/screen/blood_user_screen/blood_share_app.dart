import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  // Function to handle sharing
  void _shareApp() {
    // Share the app link
    Share.share(
      'https://play.google.com/store/apps/details?id=com.instructivetech.bloodunityapp',
    );

    // Display a SnackBar to provide feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('App Shared!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Share App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2wNu-ab4fTO54dhxk-dqef15iV3NEfHP6Ag&usqp=CAU'),
            ),
            // Text to encourage sharing
            SizedBox(height: 50),

            const Text(
              'Share our app with friends!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Share App button with icon
            ElevatedButton.icon(
              onPressed: _shareApp,
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              label: const Text(
                'Share App',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Additional sharing options with social media icons
          ],
        ),
      ),
    );
  }
}
