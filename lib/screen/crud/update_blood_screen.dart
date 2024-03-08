import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateBloodScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const UpdateBloodScreen({Key? key, required this.products}) : super(key: key);

  @override
  _UpdateBloodScreenState createState() => _UpdateBloodScreenState();
}

class _UpdateBloodScreenState extends State<UpdateBloodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            color: Color(0xFFC8291D),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Update Profile'),
              centerTitle: true,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> blood = widget.products[index];

          return Card(
            color: Color.fromARGB(255, 240, 228, 228),
            child: ListTile(
              title: Text(blood['name']),
              subtitle: Text(blood['BloodGroup']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _navigateToUpdateScreen(blood);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToUpdateScreen(Map<String, dynamic> blood) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateBloodDetailsScreen(blood: blood),
      ),
    );
  }
}

class UpdateBloodDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> blood;

  const UpdateBloodDetailsScreen({Key? key, required this.blood})
      : super(key: key);

  @override
  _UpdateBloodDetailsScreenState createState() =>
      _UpdateBloodDetailsScreenState();
}

class _UpdateBloodDetailsScreenState extends State<UpdateBloodDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.blood['name'];
    bloodGroupController.text = widget.blood['BloodGroup'];
    ageController.text = widget.blood['age'] ?? '';
    phoneNumberController.text = widget.blood['phoneNumber'] ?? '';
    cityController.text = widget.blood['city'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            color: Color(0xFFC8291D),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Update blood'),
              centerTitle: true,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: bloodGroupController,
              decoration: InputDecoration(labelText: 'BloodGroup'),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateBloodDetails();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateBloodDetails() async {
    try {
      DocumentReference bloodRef = FirebaseFirestore.instance
          .collection('all_blood')
          .doc(widget.blood['id']);

      await bloodRef.update({
        'name': nameController.text,
        'BloodGroup': bloodGroupController.text,
        'age': ageController.text,
        'phoneNumber': int.tryParse(phoneNumberController.text) ?? 0,
        'city': cityController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product details updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update product details: $e")),
      );
    }
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.7, size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 0, 0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
