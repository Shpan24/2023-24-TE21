// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapPage({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

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
            child: Text('Map',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Current Location'),
          ),
        },
      ),
    );
  }
}

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key, bool primary = false}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final Color myColor = Color.fromRGBO(128, 178, 247, 1);

  String coordinates = "No Location found";
  String address = 'No Address found';
  bool scanning = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print(serviceEnabled);

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Request Denied !');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Denied Forever !');
      return;
    }

    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      coordinates =
          'Latitude : ${position.latitude} \nLongitude : ${position.longitude}';

      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (result.isNotEmpty) {
        address =
            '${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';

        // Store location data in Firestore
        await _firestore.collection('locations').add({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'timestamp': Timestamp.now(),
        });

        // Delay navigation for 3 seconds
        await Future.delayed(Duration(seconds: 3));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapPage(
                latitude: position.latitude, longitude: position.longitude),
          ),
        );
        _updateMarkers(position.latitude, position.longitude);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }

    setState(() {
      scanning = false;
    });
  }

  void _updateMarkers(double lat, double lng) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'Current Location'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Image.asset('assets/location.jpg'),
          SizedBox(height: 20),
          Text('Current Coordinates',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
          SizedBox(height: 20),
          scanning
              ? SpinKitThreeBounce(color: myColor, size: 20)
              : Text(coordinates,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
          SizedBox(height: 20),
          Text('Current Address',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
          SizedBox(height: 20),
          scanning
              ? SpinKitThreeBounce(color: myColor, size: 20)
              : Text(address,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                checkPermission();
              },
              icon: Icon(Icons.location_pin, color: Colors.white),
              label: Text(
                'Current Location',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: myColor),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
