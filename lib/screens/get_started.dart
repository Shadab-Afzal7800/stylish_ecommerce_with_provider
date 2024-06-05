import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/home_page.dart';

// ignore: must_be_immutable
class GetStarted extends StatelessWidget {
  final String email;
  UserModel? userModel;
  User? firebaseUser;

  GetStarted({
    Key? key,
    required this.email,
    this.userModel,
    this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.5,
                        image: AssetImage(
                          "assets/images/getstarted-background.png",
                        ),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const Text(
                      "You want\nAuthentic, here\nyou go!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Find it here, Buy it now",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage(
                              userModel: userModel, firebaseUser: firebaseUser);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xffF83758),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Center(
                              child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
