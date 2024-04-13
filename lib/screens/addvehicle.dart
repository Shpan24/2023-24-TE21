// ignore_for_file: prefer_const_constructors, unnecessary_new, body_might_complete_normally_nullable, sort_child_properties_last, unused_local_variable, unused_import, unused_field

import 'package:breakdown_buddy/models/userModel.dart';
import 'package:breakdown_buddy/models/vehicleModel.dart';
import 'package:breakdown_buddy/screens/email.dart';
import 'package:breakdown_buddy/screens/razorpay.dart';
import 'package:breakdown_buddy/screens/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  int _selectedIndex = 0;
  List<vehicleDetailsModel> vehicles = [];

  final CollectionReference _database =
      FirebaseFirestore.instance.collection('vehicleDetails');

  final TextEditingController uidController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController modelController = new TextEditingController();
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController yearController = new TextEditingController();
  // final userModel uid = userMode;

  void addVehicle() {
    setState(() {
      String name = nameController.text;
      String model = modelController.text;
      String number = numberController.text;
      int year = int.tryParse(yearController.text) ?? 0;
      String currentUserId = uidController.text;

      if (name.isNotEmpty &&
          model.isNotEmpty &&
          number.isNotEmpty &&
          year > 0) {
        vehicleDetailsModel newVehicle = vehicleDetailsModel(
          uid: currentUserId,
          vehicleName: name,
          vehicleModel: model,
          vehicleNumber: number,
          year: year,
        );
        vehicles.add(newVehicle);
        // Clear input fields
        nameController.clear();
        modelController.clear();
        numberController.clear();
        yearController.clear();

        _database
            .add(newVehicle.toMap())
            .then((DocumentReference documentReference) => {
                  newVehicle.uid = documentReference.id,
                });
      } else {
        // Display an error message if any field is empty or year is not a valid number
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter valid details for all fields.'),
        ));
      }
    });
  }

  void deleteVehicle(vehicleDetailsModel vehicle) {
    _database.doc(vehicle.uid).delete().then((_) => {
          setState(() {
            vehicles.remove(vehicle);
          }),
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddVehicle()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RazorpayDemo()),
      );
    } else if (index == 2) {
      // Index 4 corresponds to the Profile icon
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'Contact Us',
                )),
      );
    }
  }

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
            child: Text('Vehicle Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Vehicle Details:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(75, 57, 239, 0.911)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Vehicle Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: modelController,
              decoration: InputDecoration(
                labelText: 'Vehicle Model',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: 'Vehicle Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: yearController,
              decoration: InputDecoration(
                labelText: 'Vehicle Year',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addVehicle();
                      // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ServiceList())));
                    },
                    child: Text(
                      'Add Vehicle',
                      style: TextStyle(
                        color: Color.fromRGBO(75, 57, 239, 0.911),
                        fontSize: 15.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromRGBO(255, 255, 255, 0.91),
                        minimumSize: Size(120, 45))),
                ElevatedButton(
                    onPressed: () {
                      // addVehicle();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ServiceList())));
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Color.fromRGBO(75, 57, 239, 0.911),
                        fontSize: 15.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromRGBO(255, 255, 255, 0.91),
                        minimumSize: Size(120, 45))),
              ],
            ),

            SizedBox(
              height: 16,
            ),
            Text(
              'Vehicle List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                              '${vehicles[index].vehicleName} (${vehicles[index].vehicleModel})'),
                          subtitle: Text(
                              'Number: ${vehicles[index].vehicleNumber}, Year: ${vehicles[index].year}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              deleteVehicle(vehicles[index]);
                            },
                          ),
                        ),
                      );
                    })),

            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedIconTheme:
              const IconThemeData(color: Color.fromRGBO(75, 57, 239, 0.911)),
          selectedLabelStyle:
              const TextStyle(color: Color.fromRGBO(75, 57, 239, 0.911)),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          iconSize: 26.0,
          selectedFontSize: 14.0,
          unselectedFontSize: 12.0,
          currentIndex: 0,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined), label: 'Make Payment'),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone_rounded), label: 'Contact Us'),
          ]),
    );
  }
}
