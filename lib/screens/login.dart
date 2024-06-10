import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/forgot_password.dart';
import 'package:stylish_flutter/screens/login_with_phone.dart';
import 'package:stylish_flutter/screens/signup_screen.dart';
import 'package:stylish_flutter/services/auth_services/login_services.dart';

class LoginScreen extends StatefulWidget {
  final UserModel? userModel;
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;

  LoginScreen({
    super.key,
    this.userModel,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginServices loginServices = LoginServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  void checkValues() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      log("Please enter valid email and password");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid email and password"),
        backgroundColor: Color(0xffF83758),
        duration: Duration(seconds: 3),
      ));
    } else {
      setState(() {
        _isLoading = true;
      });

      await loginServices.login(context, email, password);
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
                  controller: emailController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Color(0xffF3F3F3),
                      filled: true,
                      prefixIcon: Icon(Icons.person_2_rounded),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ForgotPassword();
                      }));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xffF83758)),
                    ),
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
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginWithPhone(
                                isDarkMode: widget.isDarkMode,
                                onThemeChanged: widget.onThemeChanged,
                              )));
                },
                child: Material(
                  elevation: 10.0,
                  shadowColor: const Color(0xffF3F3F3),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: const Center(
                        child: Text(
                          "LOGIN with Phone",
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
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
                          return SignupScreen(
                            userModel: widget.userModel,
                            isDarkMode: widget.isDarkMode,
                            onThemeChanged: widget.onThemeChanged,
                          );
                        }));
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Create an account ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'Sign Up',
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
