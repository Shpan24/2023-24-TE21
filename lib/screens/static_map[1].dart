// yeh purana wala hai maps ka online-offile wala bhai

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  bool _mechanicOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Mechanic'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(20.5937, 78.9629), // India coordinates
              zoom: 5.0, // Zoom level to view entire India
            ),
            markers: _markers,
          ),
          Positioned(
            top: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mechanicOnline = !_mechanicOnline;
                  if (!_mechanicOnline) {
                    _removeMarkers();
                    _fetchAndDisplayLocations();
                  }
                });
              },
              child: Text(_mechanicOnline ? 'Online' : 'Offline'),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    if (!_mechanicOnline) {
      _fetchAndDisplayLocations();
    }
  }

  void _fetchAndDisplayLocations() {
    FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double lat = doc['latitude'].toDouble();
        double lng = doc['longitude'].toDouble();
        print('Fetched location: $lat, $lng'); // Debug print
        _addMarker(lat, lng);
      });
    });
  }

  void _addMarker(double lat, double lng) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('$lat-$lng'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed), // Red marker
        ),
      );
    });
  }

  void _removeMarkers() {
    setState(() {
      _markers.clear();
    });
  }
}
