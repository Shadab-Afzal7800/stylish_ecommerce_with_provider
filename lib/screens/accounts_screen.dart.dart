import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/services/auth_services/logout_services.dart';

// ignore: must_be_immutable
class AccountsScreen extends StatefulWidget {
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  final UserModel? userModel;
  final User? firebaseUser;
  AccountsScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
    this.userModel,
    this.firebaseUser,
  });

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  LogoutServices logout = LogoutServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 5,
              shadowColor: const Color(0xffF83758),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userModel?.fullname ?? 'Guest',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.userModel?.email ?? 'Email'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text("Order history"),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text("Dark Mode"),
                        leading: const Icon(Icons.brightness_4_rounded),
                        trailing: Switch(
                            value: widget.isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                widget.isDarkMode = value;
                                widget.onThemeChanged(widget.isDarkMode);
                              });
                            }),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        logout.logout(
                            context, widget.isDarkMode, widget.onThemeChanged);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        child: const Center(child: Text("Logout")),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
