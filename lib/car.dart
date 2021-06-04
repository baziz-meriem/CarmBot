import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
class car extends StatelessWidget {
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
  child: JoystickView(
  ),

  ),
  );
  }
  }