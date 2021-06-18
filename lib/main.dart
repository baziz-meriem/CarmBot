import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_botino/Dashboard.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    ) ;
  }
}
class splashscreen extends StatefulWidget { //new class for splashscreen
  const splashscreen({Key key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds:8), () { //her duration is 6s
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      //move it to dashboard screen
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body:
           SingleChildScrollView(
             child: Container(
               margin: EdgeInsets.all(10.0),
               child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                Lottie.asset('assets/animation.json'),
                Text('Carmbot',
                  style: TextStyle( fontFamily: 'Pacifico-Regular',
                    color: Colors.purple,
                    fontSize: 45,
                    fontWeight: FontWeight.bold, ),
                ),
          ],
        ),
             ),
           ),

      );


  }
}
