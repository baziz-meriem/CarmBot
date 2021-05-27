import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: RaisedButton(
        onPressed: () {},
        color: Color(0xff64FFDA),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Text("Connect",style: TextStyle(
            color: Colors.black,
            fontFamily: 'Pacifico-Regular',
            fontWeight: FontWeight.normal,
            fontSize: 20.0),
        ),),
      );

  }
}
