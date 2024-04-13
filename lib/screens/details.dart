// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breakdown_buddy/screens/detailed_instruction.dart';
// import 'package:voice_instructions/tp.dart';
import 'package:breakdown_buddy/screens/voice_instruction.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Voice Instruction Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: AppBarTheme(
//           backgroundColor:
//               Color.fromRGBO(75, 57, 239, 0.911), // Custom background color
//           foregroundColor: Colors.white, // Text color
//           titleTextStyle: TextStyle(
//             color: Colors.white, // Title text color
//             fontSize: 20.0, // Title text size
//             fontWeight: FontWeight.bold, // Title text weight
//           ),
//           centerTitle: true, // Center align title
//           elevation: 0, // No shadow
//           iconTheme: IconThemeData(color: Colors.white), // Icon color
//         ),
//       ),
//       home: HomePage(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  // English instructions
  final List<List<String>> englishInstructions = [
    [
      "Step 1: Park your vehicle in a safe location.",
      "Step 2: Turn on hazard lights.",
      "Step 3: Locate spare tire, jack, and lug wrench.",
      "Step 4: Loosen the lug nuts.",
      "Step 5: Lift the vehicle with the jack.",
      "Step 6: Remove the lug nuts and flat tire.",
      "Step 7: Mount the spare tire and tighten the lug nuts.",
      "Step 8: Lower the vehicle and tighten the lug nuts completely.",
      "Step 9: Pack up and check the spare tire's pressure.",
    ],
    [
      "Step 1: Pull over to a safe location and turn off the engine.",
      "Step 2: Allow the engine to cool down for at least 30 minutes.",
      "Step 3: Check the coolant level and refill if necessary.",
      "Step 4: Inspect for leaks and fix if possible.",
      "Step 5: Restart the engine and check the temperature gauge.",
      "Step 6: If the temperature remains high, seek professional help.",
    ],
    [
      "Step 1: Turn off all electrical accessories (lights, radio, etc.).",
      "Step 2: Open the hood and locate the battery.",
      "Step 3: Check the battery terminals for corrosion.",
      "Step 4: Jump-start the vehicle if possible.",
      "Step 5: If jump-starting fails, call for roadside assistance or a mechanic.",
    ],
  ];

  final List<String> youtubeVideoIds = [
    "3aQRO29ZzbE", // flat tire scenario
    "QX6VYVfgDRI", // engine overheating scenario
    "-dz_XsDcH8Q", // battery failure scenario
  ];

  // Define a custom button style
  final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color.fromRGBO(75, 57, 239, 0.911), // Text color
    padding: EdgeInsets.symmetric(
        vertical: 16.0, horizontal: 24.0), // Button padding
    textStyle: TextStyle(fontSize: 18.0), // Text style
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Button border radius
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 57, 239, 0.911),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Title(
            color: Colors.white,
            child: Text('Vehicle Assistance',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add your image here
            Image.asset(
              'assets/initial.jpeg',
              fit: BoxFit.cover, // Adjust the image fit
              height: 200, // Set the image height
              width: double
                  .infinity, // Set the image width to match the screen width
            ),
            SizedBox(
                height: 20), // Add some space between the image and buttons

            Text(
              "Come on Buddy let us help you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            VoiceInstruction(
              title: "Flat Tire",
              instructions: englishInstructions[0], // English instructions
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedInstructionPage(
                      title: "Flat Tire Troubleshooting",
                      instructions: englishInstructions[0],
                      youtubeVideoId: '3aQRO29ZzbE',
                    ),
                  ),
                );
              },
              style: customButtonStyle, // Apply custom button style
            ),
            VoiceInstruction(
              title: "Engine Overheating",
              instructions: englishInstructions[1], // English instructions
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedInstructionPage(
                      title: "Engine Overheating",
                      instructions: englishInstructions[1],
                      youtubeVideoId: 'QX6VYVfgDRI',
                    ),
                  ),
                );
              },
              style: customButtonStyle, // Apply custom button style
            ),
            VoiceInstruction(
              title: "Battery Failure",
              instructions: englishInstructions[2], // English instructions
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedInstructionPage(
                      title: "Battery Failure",
                      instructions: englishInstructions[2],
                      youtubeVideoId: '-dz_XsDcH8Q',
                    ),
                  ),
                );
              },
              style: customButtonStyle, // Apply custom button style
            ),
            SizedBox(height: 10),

            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) =>
            //     //         ChatScreen(), // Assuming TpPage is the widget defined in tp.dart
            //     //   ),
            //     // );
            //   },
            //   child: Text("BUTTON"),
            //   style: customButtonStyle,
            // ),
          ],
        ),
      ),
    );
  }
}
