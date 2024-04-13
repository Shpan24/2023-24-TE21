// ignore_for_file: prefer_const_constructors

// import 'package:breakdown_buddy/screens/login.dart';
import 'package:breakdown_buddy/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breakdown Buddy',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(75, 57, 239, 0.911)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
