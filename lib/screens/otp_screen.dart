import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/home_page.dart';
import 'package:stylish_flutter/services/utilities/constants.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final UserModel? userModel;
  final User? firebaseUser;
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  OTPScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    this.userModel,
    this.firebaseUser,
    required this.onThemeChanged,
    this.isDarkMode = false,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  Color _otpFieldColor = primaryColor.withOpacity(0.1);
  String _enterOtp = "Enter your OTP";
  Color _validColor = secondaryBlack;
  Future<void> validateOTP() async {
    String otp = otpController.text.toString();
    if (otp.isEmpty || otp.toString().length < 6) {
      log("error");
      showError("Invalid OTP");
    } else {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            smsCode: otp, verificationId: widget.verificationId);
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomePage(
              userModel: widget.userModel,
              firebaseUser: widget.firebaseUser,
              onThemeChanged: widget.onThemeChanged,
            );
          }));
        });
      } catch (e) {
        showError(e.toString());
        log(e.toString());
      }
    }
  }

  void showError(String error) {
    setState(() {
      _otpFieldColor = errorRed.withOpacity(0.1);
      _enterOtp = error;
      _validColor = errorRed;
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
                height: 250,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.zero, color: primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "Enter your OTP\n",
                              style: TextStyle(
                                  color: secondaryWhite, fontSize: 30)),
                          const TextSpan(text: "\n"),
                          TextSpan(
                              text: "sent to :  (+91) ${widget.phoneNumber}",
                              style: const TextStyle(
                                  color: secondaryWhite,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))
                        ])))
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
                      _enterOtp,
                      style: TextStyle(color: _validColor),
                    ),

                    //Textfield

                    PinInputTextField(
                        controller: otpController,
                        pinLength: 6,
                        cursor: Cursor(
                            width: 2,
                            height: 25,
                            enabled: true,
                            color: secondaryBlack,
                            radius: const Radius.circular(15),
                            blinkHalfPeriod:
                                const Duration(milliseconds: 1000)),
                        autoFocus: true,
                        keyboardType: TextInputType.phone,
                        decoration: UnderlineDecoration(
                            colorBuilder: PinListenColorBuilder(
                                secondaryBlack, primaryColor),
                            bgColorBuilder: FixedColorBuilder(_otpFieldColor))),
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
                                validateOTP();
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
