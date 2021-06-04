import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:control_button/control_button.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class car extends StatelessWidget {

  JoystickDirectionCallback onDirectionChanged(
      double degrees, double distance) {
    //to print
     String data =
        "Degree : ${degrees.toStringAsFixed(2)}, distance : ${distance.toStringAsFixed(2)}";
    print(data);


  }
  const car({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
            AssetImage("assets/backgroundcar.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: InkWell(
          child: JoystickView(
            onDirectionChanged: onDirectionChanged,
          ),

        ),

      ),
    );
  }
}