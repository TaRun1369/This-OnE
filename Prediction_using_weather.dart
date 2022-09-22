import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import'dart:convert';
import 'dart:async';


void main () => runApp(
    MaterialApp(
      title:"Weather App",
      home: Home(),

    )
);

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp = 30.0;
  var description;
  var currently = 'clouds';
  var visibility = 2000;
  var windSpeed = 1.0;
  late var lon;
  late var lat;


  Future setlocation () async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
       lon = position.longitude.toString();
       lat = position.latitude.toString();

    });


  }

  Future getWeather () async {
    http.Response response = await http.get((Uri.parse)("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=6650dacbf9caa658c377bd07170c67b3"));
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.visibility = results['visibility'];
      this.windSpeed = results['wind']['speed'];
      // long = position.longitude.toString();
      // lat = position.latitude.toString();

    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
    this.setlocation();
  }


  @override
  Widget build(BuildContext context) {
    setlocation();
    getWeather();

    return Scaffold(
       body: Column(
         children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently at your location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0": "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight : FontWeight.w600,

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

          ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString(): "Loading"),


                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Visibility"),
                    trailing: Text(visibility != null ? visibility.toString() : "Loading"),

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),

                  ),
                ],
              ),
            ),
          ),
           FloatingActionButton(
             child: Text('press'),
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const Second()),
               );
             },

           ),

        ],
      ),
    );
  }
}

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {

  double a = 0.2;
  double b = 0.2;
  double c = 0.2;
  double d = 0.2;
  var TP = _HomeState().temp;
  var WS = _HomeState().windSpeed;
  var Str = _HomeState().currently;
  var VY = _HomeState().visibility;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (Str != "heavy rain") ...[
            if(VY > 100)...[
              if(WS > 50)...[
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child:
                    Opacity(
                      opacity: 1,
                      child: Center(
                        child: Image(
                          image: NetworkImage('https://images.unsplash.com/photo-1616595286596-f0b561c76bc5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80'),

                        ),
                      ),
                    ),
                  ),
                ),
              ] else if(WS > 30)...[
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child:
                    Opacity(
                      opacity: 1,
                      child: Center(
                        child: Image(
                          image: NetworkImage('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1283&q=80'),
                        ),
                      ),
                    ),
                  ),
                ),

              ]else...[
                if(TP < -10.0)...[
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child:
                      Opacity(
                        opacity: 1,
                        child: Center(
                          child: Image(
                            image: NetworkImage('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1283&q=80'),
                          ),
                        ),
                      ),
                    ),
                  ),

                ]else if(TP > 45.0)...[
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child:
                      Opacity(
                        opacity: 1,
                        child: Center(
                          child: Image(
                            image: NetworkImage('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1283&q=80'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]else...[
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child:
                      Opacity(
                        opacity: 1,
                        child: Center(
                          child: Image(
                            image: NetworkImage('https://images.unsplash.com/photo-1508357941501-0924cf312bbd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                          ),
                        ),
                      ),
                    ),
                  ),

                ]

              ]

            ]else...[
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child:
                  Opacity(
                    opacity: a,
                    child: Center(
                      child: Image(
                        image: NetworkImage('https://images.unsplash.com/photo-1586810164292-cbdf8f8e202c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80https://images.unsplash.com/photo-1586810164292-cbdf8f8e202c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                      ),
                    ),
                  ),
                ),
              ),

            ]

            // Container(
            //   height: 100,
            //   width: 100,
            //   child:
            //   Opacity(
            //     opacity: a,
            //     child: Image(
            //       image: NetworkImage('https://images.unsplash.com/photo-1508357941501-0924cf312bbd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
            //     ),
            //   ),
            // ),
          ]else...[

            Center(
              child: Container(
                height: 200,
                width: 200,
                child:
                Opacity(
                  opacity: 1,
                  child: Center(
                    child: Image(
                      image: NetworkImage('https://images.unsplash.com/photo-1616595286596-f0b561c76bc5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

