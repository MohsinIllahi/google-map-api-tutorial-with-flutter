import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.501352, 68.383796),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(25.501352, 68.383796),
    LatLng(25.495481, 68.352058),
    LatLng(25.469291, 68.374224),
    LatLng(25.462138, 68.385584),
    LatLng(25.501352, 68.383796),
  ];

  void _setPolygone() {
    _polygone.add(Polygon(
        polygonId: PolygonId('1'),
        points: points,
        strokeColor: Colors.deepOrange,
        strokeWidth: 5,
        fillColor: Colors.deepOrange.withOpacity(0.1),
        geodesic: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolygone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygone'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        markers: _markers,
        polygons: _polygone,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
