import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_botino/Dashboard.dart';

import 'ArmControl.dart';
class CarControl extends StatefulWidget {
  final BluetoothDevice server;

  const CarControl({this.server});

  @override
  _CarControl createState() => new _CarControl();
}
class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}
class _CarControl extends State<CarControl> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = List<_Message>();
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;

  var s;

  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

      Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.home, size: 40, color: Colors.white,),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Dashboard()));
              },
            ),
          ),
          body: Container(decoration: BoxDecoration(
            // make a background image in the car screen
            image: DecorationImage(
              image:
              AssetImage("assets/backgroundcar.png"),
              fit: BoxFit.cover,
            ),
          ),
            child: JoystickView(size:200,onDirectionChanged:onDirectionChanged ),
            //this joystick for control pad left,right,forward,backward her size 200px,




          ) //body:
      ),


    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }




  @override
  String  onDirectionChanged(double degrees, double distance) {
    String data = "${degrees.toStringAsFixed(0)}";
    if(degrees <=300 && degrees >249) data= "backward";
    if(degrees <=135 && degrees >45) data= "forward";
    if(degrees <=249 && degrees >135) data= "right";
    if(degrees <=45 || degrees >300) data= "left";
    print(data) ;
    _sendMessage(data);
    return data ;
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        {
          connection.output.add(utf8.encode(text + "\r\n"));
          await connection.output.allSent;

          setState(() {
            messages.add(_Message(clientID, text));
          });
        }

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      }
      catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
