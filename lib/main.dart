import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/provider/category_provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/home_page.dart';
import 'package:stylish_flutter/screens/login.dart';
import 'package:stylish_flutter/screens/onboarding_screens/onboarding.dart';
import 'package:stylish_flutter/screens/splash_screen.dart';
import 'package:stylish_flutter/services/utilities/firebase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCRhjD9JqVgUqtIBZGkBL1QQNj7rHbji18",
              appId: "1:461468564546:android:81a54affeb8a89960081db",
              messagingSenderId: "461468564546",
              projectId: "stylishecommerce"))
      : await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(const MyApp());
  }
}

//Not Logged In
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider())
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        routes: {
          '/onboard': (context) => const Onboarding(),
          '/home': (context) => const LoginScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

//Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyAppLoggedIn({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
      ),
    );
  }
}
