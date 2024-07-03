import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/view/login.dart';

class LogoutServices {
  void logout(BuildContext context, bool isDarkMode,
      ValueChanged<bool> onThemeChanged) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An unexpected error occurred. Please try again.")));
    }
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen(
          isDarkMode: isDarkMode, onThemeChanged: onThemeChanged);
    }));
  }
}
