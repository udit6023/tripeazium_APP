import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Monument {
  static const double size = 25;

  Monument({
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.image_url,

  });

  final String name;
  final String address;
  final double lat;
  final double long;
  final String image_url;
}

class MonumentMarker extends Marker {
  final Monument monument;
  MonumentMarker({required this.monument})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: Monument.size,
          width: Monument.size,
          point: LatLng(monument.lat , monument.long),
          builder: (BuildContext ctx) => const Icon(Icons.local_cafe_rounded,color: Colors.pinkAccent,),
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
            Image.network(monument.image_url),
            Text(monument.name),
            Text(monument.address),
          ],
        ),
      ),
    );
  }
}