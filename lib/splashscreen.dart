import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_botino/Dashboard.dart';

class splashscreen extends StatefulWidget { //new class for splashscreen
  const splashscreen({Key key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () { //her duration is 6s
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

        body:
           Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage("assets/dfb19993bbbabfbd110610e4dc821b65.png"),
                 fit: BoxFit.cover,
               ),
             ),
             child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              Lottie.asset('assets/animation.json'),
              Text('Carmbot',
                style: TextStyle( fontFamily: 'Pacifico-Regular',
                  color: Colors.blue,
                  fontSize: 34,
                  fontWeight: FontWeight.bold, ),
              ),
          ],
        ),
           ),

      );


  }
}
