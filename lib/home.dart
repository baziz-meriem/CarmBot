import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_botino/Dashboard.dart';
import 'package:smart_botino/connection.dart';
class home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Carmbot',
theme: ThemeData(
primarySwatch: Colors.purple,
visualDensity: VisualDensity.adaptivePlatformDensity,
),
home: FutureBuilder(
future: FlutterBluetoothSerial.instance.requestEnable(),
builder: (context, future) {
if (future.connectionState == ConnectionState.waiting)  {
return Scaffold(
body: Container(
height: double.infinity,
child: Center(
child: Image(image:AssetImage('assets/amira.jpeg')),
),
),
);
} else   {
return Dashboard();
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
          appBar: AppBar( elevation: 150, centerTitle: true,
            title: Text('Bluetooth',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico-Regular',color:  Colors.black54,  fontSize: 35.0),),shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          body: SelectBondedDevicePage(
            onCahtPage: (device1) {
              BluetoothDevice device = device1;
              Navigator.push(
                context,
                MaterialPageRoute(
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
