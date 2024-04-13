// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:async';
import 'package:breakdown_buddy/screens/initialPage.dart';
import 'package:breakdown_buddy/screens/mech_login.dart';
import 'package:flutter/material.dart';
import 'package:breakdown_buddy/screens/login.dart';
import 'package:breakdown_buddy/screens/user_services.dart';
import 'package:breakdown_buddy/screens/main_screen.dart';

// import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/logo2.jpg',
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
      ),
    );
  }
}
