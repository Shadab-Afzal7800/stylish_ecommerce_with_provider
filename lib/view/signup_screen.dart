import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/services/auth_services/signup_services.dart';
import 'package:stylish_flutter/view/login.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  final UserModel? userModel;
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  SignupScreen({
    super.key,
    this.userModel,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignUpServices signUpServices = SignUpServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  bool _isLoading = false;
  void checkValues() async {
    String? email = emailController.text.trim();
    String? password = passwordController.text.trim();
    String? confirmPassword = cpasswordController.text.trim();
    String? fullName = fullNameController.text.trim();
    if (widget.userModel != null) {
      widget.userModel!.fullname = fullName;
    }
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        fullName.isEmpty) {
      log("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all the fields"),
        backgroundColor: Color(0xffF83758),
        duration: Duration(seconds: 3),
      ));
    } else if (password != confirmPassword) {
      log("Passwords do not match");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords do not match"),
        backgroundColor: Color(0xffF83758),
        duration: Duration(seconds: 3),
      ));
    } else {
      setState(() {
        _isLoading = true;
      });

      await signUpServices.signUp(context, email, password, fullName,
          widget.isDarkMode, widget.onThemeChanged);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Welcome\nBack!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                elevation: 10.0,
                shadowColor: const Color(0xffF3F3F3),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Color(0xffF3F3F3),
                      filled: true,
                      prefixIcon: Icon(Icons.person_2_rounded),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                elevation: 10.0,
                shadowColor: const Color(0xffF3F3F3),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Color(0xffF3F3F3),
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                elevation: 10.0,
                shadowColor: const Color(0xffF3F3F3),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Color(0xffF3F3F3),
                      filled: true,
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                elevation: 10.0,
                shadowColor: const Color(0xffF3F3F3),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: TextField(
                  obscureText: true,
                  controller: cpasswordController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Color(0xffF3F3F3),
                      filled: true,
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "By clicking Register button, you agree\nto the public offer",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  checkValues();
                },
                child: Material(
                  elevation: 10.0,
                  shadowColor: const Color(0xffF3F3F3),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xffF83758),
                        borderRadius: BorderRadius.circular(14)),
                    child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                "CREATE ACCOUNT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("- OR Continue with -"),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/google-logo.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/meta-logo.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/apple-logo.png'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen(
                            isDarkMode: widget.isDarkMode,
                            onThemeChanged: widget.onThemeChanged,
                          );
                        }));
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'I Already have an account ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline))
                      ])),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
