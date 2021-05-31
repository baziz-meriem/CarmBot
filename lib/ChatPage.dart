import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_botino/Dashboard.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:control_pad/control_pad.dart';



class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = List<_Message>();
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
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

  double _value1 = 90.0;
  double _value2 = 90.0;
  double _value3 = 90.0;
  double _value4 = 90.0;

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
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Arm Control'),
            centerTitle: true,
            //centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.home,size:40,),
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard()));},
            ),
            actions: [

              IconButton(
                icon: Icon(Icons.save_alt,size:40),
                onPressed: () {},
              )
            ],
            //backgroundColor: Colors.purple,
            flexibleSpace: Container(
              decoration: BoxDecoration(
               color: Colors.deepOrangeAccent,

              ),
            ),
            bottom: TabBar(
              //isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [

                Tab(icon: InkWell(child: Icon(Icons.play_arrow),onTap:(){_sendMessage("RUN"+_value2.toString());},), text: 'RUN'),
                Tab(icon: InkWell(child: Icon(Icons.pause),onTap:(){_sendMessage("STOP"+_value2.toString());},), text: 'STOP'),
                Tab(icon: InkWell(child: Icon(Icons.restart_alt),onTap:(){_sendMessage("RESET"+_value2.toString());},), text: 'RESET'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,

          ),
        body:Container(child:Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Gripper servo',

                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico-Regular',color:
                        Colors.black54,   fontSize: 20.0),
                  ),

                  SliderTheme(data: SliderThemeData(
                      thumbColor: Colors.blue,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 70)),
                    child: SfSlider(

                      min: 0.0,
                      max: 180.0,
                      value: _value1,
                      interval: 20,
                      stepSize: 30.0,
                      showTicks: true,
                      showLabels: true,

                      //showTooltip: true,
                      showDivisors: false,
                      activeColor: Color(0xFF64FFDA),
                      inactiveColor: Color(0xFFff649f),
                      minorTicksPerInterval: 1,
                      onChanged: (dynamic value) {
                        if (isConnected) {
                          setState(() {
                            _value1 = value;
                          });

                          _sendMessage("s1"+_value1.toString());

                        }
                      },
                    ),
                  ),
                  Text(
                    'wrist servo1',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico-Regular',color: Colors.black54,   fontSize: 20.0),
                  ),

                  SliderTheme(data: SliderThemeData(
                      thumbColor: Colors.green,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 70)),
                    child: SfSlider(

                      min: 0.0,
                      max: 180.0,
                      value: _value2,
                      interval: 20,
                      stepSize: 30.0,
                      showTicks: true,
                      showLabels: true,
                      //showTooltip: true,
                      showDivisors: false,
                      activeColor: Color(0xFF64FFDA),
                      inactiveColor: Color(0xFFff649f),

                      minorTicksPerInterval: 1,
                      onChanged: (dynamic value) {
                        if (isConnected) {
                          setState(() {
                            _value2 = value;
                          });

                          _sendMessage("s2"+_value2.toString());

                        }
                      },
                    ),
                  ),
                  Text(
                    'wrist servo2',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico-Regular',color:  Colors.black54,  fontSize: 20.0),
                  ),
                  SliderTheme(data: SliderThemeData(
                      thumbColor: Colors.green,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 70)),
                    child: SfSlider(
                      min: 0.0,
                      max: 180.0,
                      value: _value3,
                      interval: 20,
                      stepSize: 30.0,
                      showTicks: true,
                      showLabels: true,
                      //showTooltip: true,
                      showDivisors: false,
                      activeColor: Color(0xFF64FFDA),
                      inactiveColor: Color(0xFFff649f),
                      minorTicksPerInterval: 1,
                      onChanged: (dynamic value) {
                        if (isConnected) {
                          setState(() {
                            _value3 = value;
                          });

                          _sendMessage("s3"+_value3.toString());

                        }
                      },
                    ),
                  ),
                  Text(
                    ' Base servo',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico-Regular',color: Colors.black54,   fontSize: 20.0),
                  ),

                  SliderTheme(data: SliderThemeData(
                      thumbColor: Colors.green,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 70)),
                    child: SfSlider(

                      min: 0.0,
                      max: 180.0,
                      value: _value4,
                      interval: 20,
                      stepSize: 30.0,
                      showTicks: true,
                      showLabels: true,
                      //showTooltip: true,
                      showDivisors: false,
                      activeColor: Color(0xFF64FFDA),
                      inactiveColor: Color(0xFFff649f),
                      minorTicksPerInterval: 1,
                      onChanged: (dynamic value) {
                        if (isConnected) {
                          setState(() {

                            _value4 = value;
                          });

                          _sendMessage("s4"+_value4.toString());

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            Row(
              children: <Widget>[


              ],
            )
          ],
        ),)  //body:
        ),
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
