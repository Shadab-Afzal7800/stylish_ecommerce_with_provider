import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/provider/category_provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/services/utilities/firebase_helper.dart';
import 'package:stylish_flutter/view/home_page.dart';
import 'package:stylish_flutter/view/login.dart';
import 'package:stylish_flutter/view/onboarding_screens/onboarding.dart';
import 'package:stylish_flutter/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCRhjD9JqVgUqtIBZGkBL1QQNj7rHbji18",
              appId: "1:461468564546:android:81a54affeb8a89960081db",
              messagingSenderId: "461468564546",
              projectId: "stylishecommerce",
              storageBucket: "stylishecommerce.appspot.com"))
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
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: isDarkMode ? Brightness.dark : Brightness.light),
        home: const SplashScreen(),
        routes: {
          '/onboard': (context) => Onboarding(
                onThemeChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                isDarkMode: isDarkMode,
              ),
          '/login': (context) => LoginScreen(
                onThemeChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                isDarkMode: isDarkMode,
              )
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

//Logged In
class MyAppLoggedIn extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyAppLoggedIn({
    super.key,
    required this.userModel,
    required this.firebaseUser,
  });

  @override
  State<MyAppLoggedIn> createState() => _MyAppLoggedInState();
}

class _MyAppLoggedInState extends State<MyAppLoggedIn> {
  bool isDarkMode = false;

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
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: isDarkMode ? Brightness.dark : Brightness.light),
        debugShowCheckedModeBanner: false,
        home: HomePage(
          userModel: widget.userModel,
          firebaseUser: widget.firebaseUser,
          onThemeChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
          },
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }
}
