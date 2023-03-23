import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';



class flutterMap extends StatefulWidget {
  const flutterMap({super.key});

  @override
  State<flutterMap> createState() => _flutterMapState();
}

class _flutterMapState extends State<flutterMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text('Leaflet Maps')),
        body: FlutterMap(
    options: MapOptions(
        center: LatLng(28.73674982409112, 77.11295999133753),
        zoom: 9.2,
    ),
    nonRotatedChildren: [
        AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
        ),
    ],
    children: [
        MarkerLayer(
            markers: [
                Marker(
                  point: LatLng(28.73674982409112, 77.11295999133753),
                  width: 80,
                  height: 80,
                  builder: (context) => FlutterLogo(),
                ),
            ],
        ),
        TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
        ),
    ],
),
    );
  }
}