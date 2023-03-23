import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
    final PopupController _popupLayerController = PopupController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(48.857661, 2.295135),
          zoom: 13.0,
          interactiveFlags: InteractiveFlag.all,
          onTap: (_, __) => _popupLayerController.hideAllPopups(),
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              markers: <Marker>[
                MonumentMarker(
                  monument: Monument(
                    name: 'Eiffel Tower',
                    imagePath:
                        'https://cdn.lifestyleasia.com/wp-content/uploads/2019/10/21224220/Winer-Parisienne.jpg',
                    lat: 48.857661,
                    long: 2.295135,
                  ),
                ),
                Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  point: LatLng(48.859661, 2.305135),
                  height: Monument.size,
                  width: Monument.size,
                  builder: (BuildContext ctx) => const Icon(Icons.shop),
                ),
              ],
              popupController: _popupLayerController,
              popupBuilder: (_, Marker marker) {
                if (marker is MonumentMarker) {
                  return MonumentMarkerPopup(monument: marker.monument);
                }
                return const Card(child: Text('Not a monument'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Monument {
  static const double size = 25;

  Monument({
    required this.name,
    required this.imagePath,
    required this.lat,
    required this.long,
  });

  final String name;
  final String imagePath;
  final double lat;
  final double long;
}

class MonumentMarker extends Marker {
  final Monument monument;
  MonumentMarker({required this.monument})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: Monument.size,
          width: Monument.size,
          point: LatLng(monument.lat, monument.long),
          builder: (BuildContext ctx) => const Icon(Icons.camera_alt),
        );

  
}


class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({Key? key, required this.monument})
      : super(key: key);
  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(monument.imagePath, width: 200),
            Text(monument.name),
            Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';


// class mapClass extends StatefulWidget {
//   late double latitude;
//   late double longitude;
//   mapClass({super.key,required this.latitude,required this.longitude});

//   @override
//   State<mapClass> createState() => _mapClassState();
// }
// class Model {
//   const Model(this.hotel, this.latitude, this.longitude);

//   final String hotel;
//   final double latitude;
//   final double longitude;
// }
// class _mapClassState extends State<mapClass> {
// late MapZoomPanBehavior _mapZoomPanBehavior;
// late List<Model> _data;
// late MapTileLayerController _controller;

//   @override
// void initState() {
//   _mapZoomPanBehavior=MapZoomPanBehavior(
//     focalLatLng: MapLatLng(widget.latitude, widget.longitude),
//     minZoomLevel: 10,
//     maxZoomLevel: 25,
//     enablePanning: true,
//     enablePinching: true,
//   );
//   super.initState();
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:CupertinoColors.systemGrey6,
//         leading: Container(
//                 width: MediaQuery.of(context).size.width,
//                 alignment: Alignment.centerLeft,
//                 child: IconButton(
//                     onPressed: (() {
//                       Navigator.pop(context);
//                     }),
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: CupertinoColors.black,
//                     )),
//               ),
        
//       ),
//       body: Stack(
//         children:[
//         SfMaps(
//           layers: [
            
//             MapTileLayer(
//               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//              zoomPanBehavior: _mapZoomPanBehavior,
//              initialMarkersCount:10,
//              markerBuilder: (BuildContext context, int index) {
//                 return MapMarker(
                  
//                     latitude: widget.latitude,
//                     longitude: widget.longitude,
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                       size: 30,
//                     ));
//               },
//             ),
//           ],
          
//         ),
//         Stack(
//               children:[
                
//                 Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color.fromARGB(180, 12, 82, 139), Color.fromARGB(255, 28, 211, 235)]),
//                     borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(40),
//                     bottomLeft: Radius.circular(40),
//                   ),
//                 ),
//                 height: MediaQuery.of(context).size.height/4,
//                 width:  MediaQuery.of(context).size.width,
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/22,left:30,right:30),
//                 child: Card(
//                   elevation: 5,
//                   child: TextField(
//                 decoration: new InputDecoration(
//                      prefixIcon: Icon(Icons.search),
//                      hintText: "Search for lounges,cafes and many more",
//                      enabledBorder: const OutlineInputBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                      borderSide: const BorderSide(
//                        color: Colors.transparent,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                    ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
//                 child: Container(
//                   child: Row(
//                     children: [
                      
//                       InkWell(
//                         onTap: () => {
//                           Fluttertoast.showToast(  
//               msg: 'Not Supported Yet',  
//               toastLength: Toast.LENGTH_SHORT,  
//               gravity: ToastGravity.BOTTOM,  
//               timeInSecForIosWeb: 1,  
//               backgroundColor: Colors.red,  
//               textColor: Colors.yellow  
//               )
//                         },
//                         child: InkWell(
//                           onTap: () => {
//                             getHotels(),
//         // Fluttertoast.showToast(  
//         //       msg: 'Not Supported',  
//         //       toastLength: Toast.LENGTH_SHORT,  
//         //       gravity: ToastGravity.BOTTOM,  
//         //       timeInSecForIosWeb: 1,  
//         //       backgroundColor: Colors.red,  
//         //       textColor: Colors.yellow  
//         //       )  
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 15,top:10,bottom: 10,right:20),
//                             child: Column(
//                               children: [
//                                 Icon(Icons.hotel),
//                                 Text("Hotels",style: TextStyle(fontWeight: FontWeight.bold),)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => {
//         Fluttertoast.showToast(  
//               msg: 'Not Supported',  
//               toastLength: Toast.LENGTH_SHORT,  
//               gravity: ToastGravity.BOTTOM,  
//               timeInSecForIosWeb: 1,  
//               backgroundColor: Colors.red,  
//               textColor: Colors.yellow  
//               )
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left:15,top:10,bottom: 10),
//                           child: Column(
//                             children: [
//                               Icon(Icons.local_cafe_sharp),
//                               Text("Cafes",style: TextStyle(fontWeight: FontWeight.bold),)
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => {
//         Fluttertoast.showToast(  
//               msg: 'Not Supported',  
//               toastLength: Toast.LENGTH_SHORT,  
//               gravity: ToastGravity.BOTTOM,  
//               timeInSecForIosWeb: 1,  
//               backgroundColor: Colors.red,  
//               textColor: Colors.yellow  
//               ) 
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 30,top:10,bottom: 10),
//                           child: Column(
//                             children: [
//                               Icon(Icons.restaurant_menu),
//                               Text("Restaurants",style: TextStyle(fontWeight: FontWeight.bold),)
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => {
//         Fluttertoast.showToast(  
//               msg: 'Not Supported',  
//               toastLength: Toast.LENGTH_SHORT,  
//               gravity: ToastGravity.BOTTOM,  
//               timeInSecForIosWeb: 1,  
//               backgroundColor: Colors.red,  
//               textColor: Colors.yellow  
//               )
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20,top:10,bottom: 10),
//                           child: Column(
//                             children: [
//                               Icon(Icons.person_pin_circle_outlined),
//                               Text("Fun Activities",style: TextStyle(fontWeight: FontWeight.bold),)
//                             ],
//                           ),
//                         ),
//                       ),
                     
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                     color: CupertinoColors.systemGrey6,
//                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   ),
//                   height: MediaQuery.of(context).size.height/8.5,
//                   width: MediaQuery.of(context).size.width,
                  
//                 ),
//               )
//               ]
//             ),
//         ]
//       ),
//     //   FlutterMap(
//     //   options: MapOptions(
//     //       center: LatLng(28.7298605, 77.0557453),
//     //       zoom: 9.2,
//     //   ),
//     //   nonRotatedChildren: [
//     //       AttributionWidget.defaultWidget(
//     //           source: 'OpenStreetMap contributors',
//     //           onSourceTapped: null,
//     //       ),
//     //   ],
//     //   children: [
//     //       TileLayer(
//     //           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//     //           userAgentPackageName: 'com.example.app',
//     //       ),

//     //       MarkerClusterLayerOptions(builder: builder)
//     //   ],
//     // ),
//     );
//   }
  
//   getHotels() {


//     _data = <Model>[
//     Model("Nine Dragon", 28.71630722192371,77.12026457477475),
//      Model("The Crispy Bites", 28.736272067372607,77.1135827015149),
//       Model("Nine Dragon", 28.73486100606598,77.11220034016418),

//   ];
//   _controller = MapTileLayerController();
//   }
// }