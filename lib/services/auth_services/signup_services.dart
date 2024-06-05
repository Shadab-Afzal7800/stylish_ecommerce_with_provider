import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/login.dart';

class SignUpServices {
  void signUp(
    BuildContext context,
    String email,
    String password,
    String fullName,
  ) async {
    UserCredential? credentials;
    try {
      credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    if (credentials != null) {
      String uid = credentials.user!.uid;
      UserModel newUser = UserModel(uid: uid, email: email, fullname: fullName);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        log("new User created");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }));
      });
    }
  }
}
