import 'package:flutter/material.dart';
import 'package:smart_botino/Bluetooth_Connection.dart';
import 'package:smart_botino/Dashboard.dart';

class BlueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
        elevation: 150,
        centerTitle: true,
        title: Text(
          'Bluetooth',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico-Regular',
              color: Colors.black54,
              fontSize: 35.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SelectBondedDevicePage(/**/
        onArmControl: (device1) {/**/
          Navigator.push(
            context,
            MaterialPageRoute(/*to navigate screens*/
              builder: (context) {
                return Dashboard();
              },
            ),
          );
        },
      ),
    ));
  }
}
