// ignore_for_file: prefer_const_constructors

import 'package:breakdown_buddy/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
//       ),
//       home: const MyHomePage(title: 'Contact Us'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            child: Text('Contact Us',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.3), // Shadow color
                    //     spreadRadius: 2.0, // Spread radius
                    //     blurRadius: 10.0, // Blur radius
                    //     // offset: Offset(0, 3), // Shadow offset
                    //   ),
                    // ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/contact.jpg',
                      width: 360.0,
                      height: 200.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "We value your feedback and inquiries",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(75, 57, 239, 0.911),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 23),
            Text(
              "Let us know how we can assist you :)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  size: 35,
                  color: Color.fromRGBO(75, 57, 239, 0.911),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'default@example.com',
                        style: TextStyle(fontSize: 18), // Increase font size
                      ),
                      SizedBox(width: 50),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(75, 57, 239, 0.911),
                          // Set button color to blue
                          borderRadius:
                              BorderRadius.circular(8), // Round corners
                        ),
                        child: TextButton(
                          onPressed: () async {
                            String? encodeQueryParameters(
                                Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }

                            // Send button action
                            // print('Sending email...');
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: 'hiteshpunjabi300@gmail.com',
                              query: encodeQueryParameters(<String, String>{
                                'subject':
                                    'Example Subject & Symbols are allowed!',
                                'body': 'Don\'t forget to subscribe',
                              }),
                            );

                            if (await canLaunch(emailUri.toString())) {
                              launch(emailUri.toString());
                            } else {
                              throw Exception('Could not launch $emailUri');
                            }
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ), // Set text color to white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 35,
                  color: Color.fromRGBO(75, 57, 239, 0.911),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '+91 9323681540',
                        style: TextStyle(fontSize: 18), // Increase font size
                      ),
                      SizedBox(width: 95),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                              75, 57, 239, 0.911), // Set button color to blue
                          borderRadius:
                              BorderRadius.circular(8), // Round corners
                        ),
                        child: TextButton(
                          onPressed: () {
                            launch('tel:+91 9323681540');
                          },
                          child: const Text(
                            'Call',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0), // Set text color to white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            // Row(
            //   children: [
            //     Icon(Icons.web),
            //     SizedBox(width: 15),
            //     Expanded(
            //       child: Row(
            //         children: [
            //           Text(
            //             'www._Buddy_.com',
            //             style: TextStyle(fontSize: 18), // Increase font size
            //           ),
            //           SizedBox(width: 10),
            //           Container(
            //             decoration: BoxDecoration(
            //               color: Colors.blue, // Set button color to blue
            //               borderRadius:
            //                   BorderRadius.circular(10), // Round corners
            //             ),
            //             child: TextButton(
            //               onPressed: () {
            //                 launch('https://www.BreakDown.com');
            //               },
            //               child: const Text(
            //                 'Visit Website',
            //                 style: TextStyle(
            //                     color: Colors.white), // Set text color to white
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        75, 57, 239, 0.911), // Set button color to blue
                    borderRadius: BorderRadius.circular(10), // Round corners
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => HomePage())));
                      },
                      child: Text('Get Simple Help',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
