import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/login.dart';

class SignUpServices {
  Future<bool> signUp(
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
          return LoginScreen();
        }));
      });
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An unexpected error occurred. Please try again.")));
    }
    return false;
  }
}
