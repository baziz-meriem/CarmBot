import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_botino/connection.dart';
import 'package:smart_botino/led.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arpoux',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          } else {
            return Home();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Connection'),
          ),
          body: SelectBondedDevicePage(
            onCahtPage: (device1) {
              BluetoothDevice device = device1;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage(server: device);
                  },
                ),
              );
            },
          ),
        ));
  }
}
