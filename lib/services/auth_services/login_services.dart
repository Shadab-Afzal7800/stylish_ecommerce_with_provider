import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/view/get_started.dart';

class LoginServices {
  Future<bool> login(
      BuildContext context, String email, String password) async {
    // ignore: unused_local_variable
    UserCredential? credentials;
    try {
      credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GetStarted(
          email: email,
        );
      }));
      log("Logged in");
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An unexpected error occurred. Please try again.")));
    }
    return false;
  }
}
