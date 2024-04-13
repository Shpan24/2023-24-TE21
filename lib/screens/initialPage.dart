// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'static_map[1].dart';
import 'package:breakdown_buddy/screens/mech_login.dart';
import 'package:breakdown_buddy/screens/login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: AnimatedContainer(
              duration: Duration(seconds: 1), // Set animation duration
              child: Container(
                height: 20, // Reduced height
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to match screen width
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Make the container circular
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/initial.jpeg'), // Replace with your image URL
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Adjust button width based on screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen(title: 'breakdown buddy')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          75, 57, 239, 0.911), // Set button background color
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Adjust vertical padding as needed
                    ),
                    child: Text(
                      'Login as a User',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Adjust button width based on screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MechLogin()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          75, 57, 239, 0.911), // Set button background color
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Adjust vertical padding as needed
                    ),
                    child: Text(
                      'Login as a Mechanic',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
