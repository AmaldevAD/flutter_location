import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';



class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

//start
class _HomeState extends State<Home> {
  var latitude;
  var longitude;
  var lat;
  var long;
  var cittic;
  var merih;
  var flag;
  var location = new Location();
  Distance distance = new Distance();
 // FirebaseDatabase firebaseDatabase = FirebaseDatabaDse.instance.reference();
 final FirebaseDatabase database =  FirebaseDatabase.instance;
  

  getLocation() async {
    location.onLocationChanged().listen((LocationData currentLocation) {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      setState(() {
        latitude = lat;
        longitude = long;
      });
    });

    setState(() {
      //cittic
      cittic = distance(
          new LatLng(latitude, longitude), new LatLng(10.041113, 76.328093));
      merih =
          distance(LatLng(latitude, longitude), LatLng(10.046278, 76.336240));
    });
  }

  //image Widget
 Widget image() {
  
      if (cittic < 500.toInt()) {
        return Image.asset("images/cittic.jpg",height: 50,width: 50,);
      } else 
      if (merih < 20.toInt()) 
      {
        database.reference().child("Maharajas").set({"flag":"true"});
      return Image.asset("images/merih.jpg",height: 50,width: 50,);
      }
      else
      {
        database.reference().child("Maharajas").set({"flag":"false"});
      return Text("hii");
      }
  
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    // setState(() {
    //  database.reference().child("Maharajas").once().then((DataSnapshot snapshot){
    //   Map<dynamic,dynamic> list= snapshot.value;
    //   print("${list.values}");
    //  });
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text("Times_of_india"),
      ),
      body: ListView(
        children: <Widget>[
          //10.041113, 76.328093
                image(),
                Image.asset("images/merih.jpg"),
           Text("$cittic"),
           Text("$merih")
        ],
      ),
    );
  }
}
