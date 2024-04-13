// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayOnPage extends StatefulWidget {
  const DisplayOnPage({Key? key}) : super(key: key);

  @override
  _DisplayOnPageState createState() => _DisplayOnPageState();
}

class _DisplayOnPageState extends State<DisplayOnPage> {
  String _locationText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getLocationFromDB,
              child: Text('Get Location from DB'),
            ),
            SizedBox(height: 20),
            Text(
              _locationText,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showLocationPopup();
              },
              child: Text('Show Location Popup'),
            ),
          ],
        ),
      ),
    );
  }

  void _getLocationFromDB() {
    FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          double lat = doc['latitude'];
          double lng = doc['longitude'];
          _locationText = 'Latitude: $lat, Longitude: $lng';
        });
      });
    }).catchError((error) {
      print('Error fetching location: $error');
      setState(() {
        _locationText = 'Error fetching location: $error';
      });
    });
  }

  void _showLocationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Details'),
          content: Text(_locationText),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
