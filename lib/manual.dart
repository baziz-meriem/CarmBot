import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class manual extends StatelessWidget {
  const manual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar (
        title: new Text("about us"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellowAccent[200],Colors.blue[600]],
              //appbar with linearColor
              begin: Alignment.bottomRight,  //from the right to the left
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Stack(
        children:<Widget>[
          Container(decoration: BoxDecoration(
            // make a background image in the car screen
            image: DecorationImage(
              image:
              AssetImage("assets/aboout us.png"),
              fit: BoxFit.fill,
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),  //make the text in the begining
            //create child to add a text
            child: Card(
              child: Text(
                "Please feel free to contact us if you have any questions our emails are provided below ",
                textAlign: TextAlign.center, //text align to fix the text in the center
                style: TextStyle(
                  fontFamily: 'Pacifico-Regular',
                  //our font is Regular in this screen

                  fontSize: 25.0,
                  color :Color(0xff697bf0),
                  fontWeight: FontWeight.bold,
                ),


              ),
            ),

          ),
          new ListView(  //listview to create a horizontal scroling of images
            children: <Widget>[
              new Container(  //in the list view create a container to make all the images there
                height: 600.0,
                margin: EdgeInsets.all(10.0),

                child: new ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    new Container(
                      margin: EdgeInsets.symmetric(vertical: 150.0),
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(17.0),
                        child: new Image(image: new AssetImage("assets/manal.png"),
                          width: 200.0,
                          height: 600.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.symmetric(vertical: 150.0),
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(17.0),
                        child: new Image(image: new AssetImage("assets/afraa.png"),
                          width: 200.0,
                          height: 600.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.symmetric(vertical: 150.0),
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(17.0),
                        child: new Image(image: new AssetImage("assets/amirameriem.png"),
                          width: 200.0,
                          height: 600.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.symmetric(vertical: 150.0),
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(17.0),
                        child: new Image(image: new AssetImage("assets/naila.png"),
                          width: 200.0,
                          height: 600.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ], ),
    );
  }
}