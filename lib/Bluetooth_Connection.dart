import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'Dashboard.dart';

class BlueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: new AppBar (
              elevation: 150,
              centerTitle: true,
              title:  Text("Bluetooth",
             style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico-Regular',
                  color: Colors.white,
                  fontSize: 35.0),
            ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black,Colors.purple[200]],
                    //appbar with linearColor
                    begin:   Alignment.bottomRight,  //from the right to the left
                    end: Alignment.topLeft,
                  ),
                ),
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

class BluetoothDeviceListEntry extends StatelessWidget {/*.immutable.*/
  final Function onTap;/*The base class for all function types */
  final BluetoothDevice HC05;

  BluetoothDeviceListEntry({this.onTap, @required this.HC05});/*...constructor..*/

  @override
  Widget build(BuildContext context)/*Describes the part of the user interface represented by this widget.*/ {
    return Card(

      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.devices),/*a widget to display before the title*/
        title: Text(HC05.name ?? "Unknown device"),
        subtitle: Text(HC05.address.toString()),
        // ignore: deprecated_member_use
        trailing: RaisedButton(
          onPressed: () {},

          color: Colors.purple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70)),
          child: Text("Connect",style: TextStyle(
              color: Colors.black,
              fontFamily: 'Pacifico-Regular',
              fontWeight: FontWeight.normal,
              fontSize: 20.0),
          ),),
         
    ),
    );
  }
}


/*.................widget part........*/
class SelectBondedDevicePage extends StatefulWidget {/* has a changing state*/
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool checkAvailability;/*what does it do??*/
  final Function onArmControl;
  final Function onCarControl;

  const SelectBondedDevicePage({this.checkAvailability = true, @required this.onArmControl, this.onCarControl});/* constructor ??? */

  @override
  _SelectBondedDevicePage createState() => new _SelectBondedDevicePage();/*to rely between the stateful widget and it's widget??*/
}
/*enumeration, defining named constant values*/
enum _DeviceAvailability {
  // ignore: unused_field
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);/*constructor*/
}
/*.................widget state part........*/
class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = <_DeviceWithAvailability>[];

  // Availability
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;/**/
  bool _isDiscovering;/**/
  _SelectBondedDevicePage();/**/

  @override
  void initState()/* initialisation appears first*/ {
    super.initState();
    _isDiscovering = widget.checkAvailability;/**/

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {/**/
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() /* refresh,update*/{
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose()/*is called when the state is deleted*/ {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) /*builds our widget */{/* adds a List containing our devices*/
    List<BluetoothDeviceListEntry> list = devices
        .map(
          (_HC05) => BluetoothDeviceListEntry(
            HC05: _HC05.device,
            // rssi: _device.rssi,
            // enabled: _device.availability == _DeviceAvailability.yes,
            onTap: () {
              widget.onArmControl(_HC05.device);
              widget.onCarControl(_HC05.device);
            },
          ),
        )
        .toList();
    return ListView(children: list,);
  }
}
