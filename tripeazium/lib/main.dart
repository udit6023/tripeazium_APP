import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripeazium/views/HomeScreen.dart';
import 'package:tripeazium/views/dropDownPage.dart';
import 'package:tripeazium/views/flutter_map.dart';
import 'package:tripeazium/views/map.dart';
import 'package:tripeazium/views/splashScreen.dart';
import 'package:location/location.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //LocationService();
  runApp(const MyApp());
  
}
Future LocationService() async {
  var location = Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return;
    }
  }

  var loc = await location.getLocation();
  print("lat"+"${loc.latitude} ${loc.longitude}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:dropDown(),
    );
  }
}




