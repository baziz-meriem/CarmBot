import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_botino/Dashboard.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body:
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            Lottie.asset('assets/animation.json'),
            Text('Carmbot',
              style: TextStyle( fontFamily: 'Pacifico-Regular',
                fontSize: 34,
                fontWeight: FontWeight.bold, ),
            ),
          ],
        ),

      );


  }
}
