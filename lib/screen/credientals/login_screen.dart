import 'package:bloodunity/screen/credientals/forgot_screen.dart';
import 'package:bloodunity/screen/credientals/signup_screen.dart';
import 'package:bloodunity/screen/home/home_screen.dart';
import 'package:bloodunity/widgets/accont_selection.dart';
import 'package:bloodunity/widgets/custom_button.dart';
import 'package:bloodunity/widgets/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscureText = true;
  bool _isLoading = false;

  Future<void> _loginCredentials() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailC.text, password: _passwordC.text);

        if (userCredential.user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return HomeScreen();
          }));
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message ?? 'An error occurred');
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      height: size.height * 1.0,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'WELCOME TO \n BLOOD UNITY APP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/premium-vector/3d-blood-type-b-o-ab-red-symbol-icon-vector-isolated-white-background-3d-blood-donation-medical-healthcare-concept-cartoon-minimal-style-3d-icon-vector-render-illustration_726846-5858.jpg',
                            ),
                          ),
                          CustomTextField(
                            textEditingController: _emailC,
                            prefixIcon: Icons.email_outlined,
                            hintText: 'Enter Email',
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Email should not be empty';
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                  .hasMatch(v)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            textEditingController: _passwordC,
                            prefixIcon: Icons.password_outlined,
                            obscureText: _isObscureText,
                            hintText: 'Enter Password',
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Password should not be empty';
                              } else if (v.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            suffixWidget: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscureText = !_isObscureText;
                                });
                              },
                              icon: Icon(
                                _isObscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : MaterialButton(
                                  height: 50.0,
                                  minWidth: 120.0,
                                  color: Colors
                                      .red, // Set your desired button color
                                  onPressed: _isLoading
                                      ? null
                                      : () {
                                          _loginCredentials();
                                        },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set your desired text color
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) {
                                    return const ForgetPasswordScreen();
                                  }),
                                );
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          AccountSelection(
                            title: "Don't have an Account?",
                            buttonTitle: 'CREATE ACCOUNT',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return const SignUpScreen();
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
