import 'package:flutter/material.dart';
import 'package:smart_botino/ChatPage.dart';
import 'package:smart_botino/main.dart';

class Dashboard extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        body: Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage("assets/60ac66ae2cf6843b28687fc143861404.png"),
                fit:BoxFit.cover,
              ),

            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon:Icon(Icons.bluetooth, color: Colors.white,size: 52.0),
                          iconSize:50,
                          tooltip: "meriem",
                          splashColor:Color(0xff69f0ae),
                          onPressed:(){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:(context)=> Home()
                              )
                            );
                          },
                         ),
                        IconButton(
                          icon:Icon(Icons.settings,color:Colors.white,size:52.0),
                          iconSize:50,
                          splashColor:Color(0xff69f0ae),
                          onPressed:(){},)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Welcome, Armbotino \nSelect an option",
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        color: Color(0xff061407),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,

                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(

                      child: Wrap(
                          spacing:20,
                          runSpacing: 20.0,
                          children: <Widget>[
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(),
                                  height: 100, width: 100,
                                  child: Card(
                                    shadowColor:Color(0xff69f0ae),
                                    color: Color.fromARGB(255, 255, 254, 255),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0)
                                    ),
                                    child:Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:(context)=> ChatPage()
                                                          )
                                                      );
                                                    },
                                                    child: Container(
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                        child: Image.asset('assets/todo.png',
                                                            width: 100.0, height: 75.0),
                                                      ),),
                                                  )
                                              ),

                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "Arm Control",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "4 Axis",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w100
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                onTap: (){},
                              ),


                            ),


                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(
                                shadowColor:Color(0xff69f0ae),
                                color: Color.fromARGB(255, 252, 252, 252),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Material(
                                              child: InkWell(
                                                onTap: () {
                                                  var device;
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:(context)=>ChatPage(server: device)
                                                      )
                                                  );
                                                },
                                                child: Container(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child: Image.asset('assets/note.png',
                                                        width: 100.0, height: 75.0),
                                                  ),),
                                              )
                                          ),

                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Car control",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'DancingScript',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "2 motors",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width:160.0,
                              height: 160.0,

                            ),

                          ]),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
