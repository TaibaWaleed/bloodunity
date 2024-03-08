import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/widgets/custom_button.dart';
import 'package:bloodunity/widgets/custom_text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: 'Password reset email sent successfully.');
      navigateTo(context, LogInScreen());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                ///title
                ' BLOOD UNITY \n Forget Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ///Circle Avatar
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/premium-vector/3d-blood-type-b-o-ab-red-symbol-icon-vector-isolated-white-background-3d-blood-donation-medical-healthcare-concept-cartoon-minimal-style-3d-icon-vector-render-illustration_726846-5858.jpg',
                ),
              ),

              ///custom text feild email
              CustomTextField(
                textEditingController: emailController,
                prefixIcon: Icons.email_outlined,
                hintText: 'Enter Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              _isLoading
                  ? const CircularProgressIndicator()

                  ///material forgot button
                  : MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text.trim();
                          resetPassword(context, email);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50, // Adjust the height as needed
                      minWidth: 120, // Adjust the width as needed
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          _isLoading ? 'Sending Request...' : 'Send Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
