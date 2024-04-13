// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class SeeOnMap extends StatefulWidget {
  const SeeOnMap({Key? key}) : super(key: key);

  @override
  _SeeOnMapState createState() => _SeeOnMapState();
}

class _SeeOnMapState extends State<SeeOnMap> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See Location on Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(20.5937, 78.9629), // India coordinates
          zoom: 4.0,
        ),
        markers: _markers,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _fetchAndDisplayLocations();
  }

  void _fetchAndDisplayLocations() {
    FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double lat = doc['latitude'].toDouble();
        double lng = doc['longitude'].toDouble();
        _addMarker(lat, lng);
      });
    }).catchError((error) {
      print('Error fetching location: $error');
    });
  }

  void _addMarker(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      onTap: () {
        _showLocationPopup(lat, lng);
      },
    );
    setState(() {
      _markers.add(marker);
    });
  }

  void _showLocationPopup(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark placemark = placemarks.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Latitude: $lat'),
              Text('Longitude: $lng'),
              Text(
                  'Address: ${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Reject'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationDetailsPage(
                          lat: lat, lng: lng, address: placemark.toString())),
                );
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }
}

class LocationDetailsPage extends StatelessWidget {
  final double lat;
  final double lng;
  final String address;

  const LocationDetailsPage(
      {Key? key, required this.lat, required this.lng, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(75, 57, 239, 0.911),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/location_image.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(0, 0, 0, 0.915).withOpacity(0.3),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildDetailItem('Latitude', lat.toString()),
                  _buildDetailItem('Longitude', lng.toString()),
                  _buildDetailItem('Address', address),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(75, 57, 239, 0.911)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(75, 57, 239, 0.911)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(8, 1, 1, 0.975),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(15, 15, 15, 1),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SeeOnMap(),
  ));
}
