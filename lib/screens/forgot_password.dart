import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
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
                "Forgot\nPassword?",
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
                      hintText: 'Enter your email address',
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
                    "* We will send you a message\n   to set or reset your new password",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Material(
                elevation: 10.0,
                shadowColor: const Color(0xffF3F3F3),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xffF83758),
                      borderRadius: BorderRadius.circular(14)),
                  child: const Center(
                      child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
