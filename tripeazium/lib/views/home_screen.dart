import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import "package:flutter_map_marker_popup/flutter_map_marker_popup.dart";
import 'package:tripeazium/models/cafeModel.dart';
import 'package:tripeazium/views/home_screen.dart';
import 'package:tripeazium/views/home_screen.dart';

import '../classes/cafeClass.dart';
import 'Popup.dart';

class HomeScreen extends StatefulWidget {
  late double latitude;
  late double longitude;
  late String name;
  HomeScreen({super.key,required this.latitude,required this.longitude,required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class CafeList {
  const CafeList(this.cafeName,this.targetClgName,this.latitude,this.longitude);

  final String cafeName;
  final String targetClgName;
  final double latitude;
  final double longitude;
}
class _HomeScreenState extends State<HomeScreen> {
final PopupController _popupLayerController = PopupController();
late final MapController mapController;

 List<CafeModel> cafeList = [];
 
late List<Marker> marker=[
     Marker(point: LatLng(widget.latitude, widget.longitude), builder: (BuildContext context) { 
      return Icon(Icons.location_on_outlined,color: Colors.red,size: 30,);
     }                  
    ),
                      
];
// List<List<CafeList>> list=[
//   [
//     CafeList("Nine Dragon", "Bhagwan Parshuram Insitute of Technology, Rohini",28.71630722192371,77.12026457477475),
//     CafeList("The Crispy Bites", "Bhagwan Parshuram Insitute of Technology, Rohini",28.736272067372607,77.1135827015149),
//     CafeList("Waffleness by Big Bowl", "Bhagwan Parshuram Insitute of Technology, Rohini",28.73486100606598,77.11220034016418),
//     CafeList("Burger Bistro, G3S", "Bhagwan Parshuram Insitute of Technology, Rohini",28.735043351400595,77.11408944006753),
//     CafeList("Crazy Crisp", "Bhagwan Parshuram Insitute of Technology, Rohini",28.740606553921378,77.12344885776295),
//   ],
//   [
//     CafeList("Café Maddox", "Bharti Vidyapeeth College of Engineering, Paschim Vihar",28.677296337476996,77.11185506400025),
//     CafeList("Vegaan café", "Bharti Vidyapeeth College of Engineering, Paschim Vihar",28.669334059681006,77.10582037888906),
//     CafeList("Skippers Café", "Bharti Vidyapeeth College of Engineering, Paschim Vihar",28.669826592703767,77.10928796965945),
//     CafeList("American Daddy, G3S", "Bharti Vidyapeeth College of Engineering, Paschim Vihar",28.66819768611268,77.11249258620258),
//     CafeList("Café After Hours", "Bharti Vidyapeeth College of Engineering, Paschim Vihar",28.670347460766113,77.10926766030316),
//   ],
//   [
//     CafeList("Chaayos", "Gitarattan Institute of Advanced Studies, Rohini",28.708834842420355,77.12435940038596),
//     CafeList("The Burger Club", "Gitarattan Institute of Advanced Studies, Rohini",28.709128238713642,77.12419148249111),
//   ],
//   [
//     CafeList("The Crispy Bites", "Keshav Mahavidyalya, PitamPura",28.68851350595149, 77.12130502211548),
//     CafeList("Chef Nation", "Keshav Mahavidyalya, PitamPura",28.688280499402314, 77.12175374425408),
//     CafeList("Sow Café", "Keshav Mahavidyalya, PitamPura",28.693724592587067, 77.1224884235096),
//     CafeList("Xero Degrees", "Keshav Mahavidyalya, PitamPura",28.689507039673178, 77.13639916351434),
//     CafeList("Café Russmunch", "Keshav Mahavidyalya, PitamPura",28.69068070271184, 77.13629418784583),
//   ],
//   [
//     CafeList("Kartoon Café", "Maharaja Surajmal Institute of Technology, JanakPuri",28.61813119412517, 77.09301744378878),
//     CafeList("Raw Creams", "Maharaja Surajmal Institute of Technology, JanakPuri",28.619247534193676, 77.09200076822636),
//     CafeList("Two Pots Kitchen", "Maharaja Surajmal Institute of Technology, JanakPuri",28.618195199788616, 77.09453437067108),
//     CafeList("Café Punjab", "Maharaja Surajmal Institute of Technology, JanakPuri",28.61870408965644, 77.09159244908824),
//     CafeList("Food G", "Maharaja Surajmal Institute of Technology, JanakPuri",28.618775672565352, 77.09288584277203),
//   ]
  
// ];

loadCafes()async{
  final url = "https://tripeazium-backend.onrender.com/api/main/get_cafes";
final response = await http.get(Uri.parse(url));
final modelJson = response.body;
final decodedData = jsonDecode(modelJson) as List;


  for(int i=0;i<decodedData.length;i++)
  {
    CafeModel cafeModel=CafeModel();
    cafeModel.name=decodedData[i]["name"].toString();
    cafeModel.college=decodedData[i]["college"].toString();
    cafeModel.latitude=decodedData[i]["latitude"].toString();
    cafeModel.longitude=decodedData[i]["longitude"].toString();
    cafeModel.address=decodedData[i]["address"].toString();
    cafeModel.image_url=decodedData[i]["image_url"].toString();
  print(decodedData[i]["name"]);
    cafeList.add(cafeModel);
  }
  

}

@override
  void initState() {
    // TODO: implement initState
      loadCafes();
    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    marker=[];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
          padding:EdgeInsets.only(right: MediaQuery.of(context).size.width/175),
          child: IconButton(
          icon: Image.asset('assests/logo_trpeazium.png'),
          iconSize: 120,
          onPressed: (){},
      ),
        ),
          backgroundColor:CupertinoColors.systemGrey6,
          leading:Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: Icon(
                      Icons.arrow_back,
                      color: CupertinoColors.black,
                    )),
              ),
        ),
        body:  Stack(
          children:[
             FlutterMap(
              options: MapOptions(
                
                center: LatLng(widget.latitude, widget.longitude),
                 onTap: (_, __) => _popupLayerController
                .hideAllPopups(),
                  minZoom: 10.0),
              children: [
                 TileLayer(
                    urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c']),
                 new PopupMarkerLayerWidget(
              options: PopupMarkerLayerOptions(
                popupController: _popupLayerController,
                
                markers: marker,
                
                markerRotateAlignment:
                    PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                popupBuilder: (_, Marker marker) {
                if (marker is MonumentMarker) {
                  return MonumentMarkerPopup(monument: marker.monument);
                }
                return Card(child: Text(widget.name,style: TextStyle(fontSize: 15),));
              },    
              ),
                
            ),
              ]),

              Stack(
              children:[
                
                Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(180, 12, 82, 139), Color.fromARGB(255, 28, 211, 235)]),
                    borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                height: MediaQuery.of(context).size.height/4,
                width:  MediaQuery.of(context).size.width,
              ),
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/22,left:30,right:30),
                child: Card(
                  elevation: 5,
                  child: TextField(
                decoration: new InputDecoration(
                     prefixIcon: Icon(Icons.search),
                     hintText: "Search for lounges,cafes and many more",
                     enabledBorder: const OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                     borderSide: const BorderSide(
                       color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                   ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
                child: Container(
                  child: Row(
                    children: [
                      
                      InkWell(
                        onTap: () => {
                          Fluttertoast.showToast(  
              msg: 'Not Supported Yet',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: InkWell(
                          onTap: () async => {
                            await getHotels(),
        // Fluttertoast.showToast(  
        //       msg: 'Not Supported',  
        //       toastLength: Toast.LENGTH_SHORT,  
        //       gravity: ToastGravity.BOTTOM,  
        //       timeInSecForIosWeb: 1,  
        //       backgroundColor: Colors.red,  
        //       textColor: Colors.yellow  
        //       )  
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top:10,bottom: 10,right:20),
                            child: Column(
                              children: [
                                Icon(Icons.local_cafe_sharp),
                                Text("Cafes",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:15,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.hotel),
                              Text("Hotels",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              ) 
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.restaurant_menu),
                              Text("Restaurants",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.person_pin_circle_outlined),
                              Text("Fun Activities",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  height: MediaQuery.of(context).size.height/8.5,
                  width: MediaQuery.of(context).size.width,
                  
                ),
              )
              ]
            ),
          ],
        ));
  }
  
  getHotels() {
    for(var i=0;i<cafeList.length;i++){
      
        if(widget.name==cafeList[i].college){
          print(cafeList[i].college);
          setState(() {
          
            marker.add(
            MonumentMarker(monument:Monument(name: cafeList[i].name, lat:double.parse(cafeList[i].latitude), long: double.parse(cafeList[i].longitude), address: cafeList[i].address, image_url: cafeList[i].image_url)
                       
            ),
          );
          });
         
        }
    }
  }
 
}

