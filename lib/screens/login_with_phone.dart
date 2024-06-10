import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/screens/otp_screen.dart';
import 'package:stylish_flutter/services/utilities/constants.dart';

class LoginWithPhone extends StatefulWidget {
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  LoginWithPhone({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneController = TextEditingController();

  String _infoText = "You will get code via SMS";
  Color _infoTextColor = secondaryBlack;
  Color _labelTextColor = secondaryBlack;
  Color _prefixIconColor = primaryColor;
  Future<void> validatePhoneNumber() async {
    String phone = phoneController.text.trim();
    String formattedPhone = "+91$phone";

    if (formattedPhone.isEmpty || formattedPhone.toString().length < 13) {
      showError("Invalid Phone Number");
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showError(e.toString());
          log(e.toString());
        },
        codeSent: (String verificationId, int? resendingToken) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return OTPScreen(
              phoneNumber: formattedPhone,
              verificationId: verificationId,
              onThemeChanged: widget.onThemeChanged,
              isDarkMode: widget.isDarkMode,
            );
          }));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      log(formattedPhone);
    }
  }

  void showError(String error) {
    log("error called");
    setState(() {
      _infoText = error;
      _infoTextColor = errorRed;
      _labelTextColor = errorRed;
      _prefixIconColor = errorRed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(100100, 20000)),
                    color: primaryColor),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Enter your\nmobile phone",
                        style: TextStyle(color: secondaryWhite, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.9,
                // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _infoText,
                      style: TextStyle(color: _infoTextColor),
                    ),

                    //TextField
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          prefix: const Text("+91"),
                          labelText: "Phone",
                          labelStyle: TextStyle(color: _labelTextColor),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // hintText: "Phone",
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                          prefixIconColor: _prefixIconColor,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: IconButton(
                              onPressed: () {
                                validatePhoneNumber();
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: secondaryWhite,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
