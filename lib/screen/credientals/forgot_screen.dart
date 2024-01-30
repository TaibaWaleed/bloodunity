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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Forget Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://scontent.flhe2-2.fna.fbcdn.net/v/t39.30808-6/419252893_372550232090493_1583071094400664806_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeFsLXfnq0bEasv9s99ciOF_ch-KVVJZYh1yH4pVUlliHV6A0XtqPpRzpPcaqHd6xYSx_L7Aa7YmYcQfrtsms4Iq&_nc_ohc=o49Loh8wl1AAX8O4F6W&_nc_zt=23&_nc_ht=scontent.flhe2-2.fna&oh=00_AfBTppw1swg6xG9nXb7zBkmfmzA2pLzmUOkxoioa0lvOMA&oe=65ACC06A'),
                  ),
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
                      : CustomButton(
                          title: _isLoading
                              ? 'sending request.....'
                              : 'send request',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String email = emailController.text.trim();
                              resetPassword(context, email);
                            }
                          },
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
