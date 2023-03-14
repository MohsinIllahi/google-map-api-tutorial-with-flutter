import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({super.key});

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  List<LatLng> latlng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9907),
    LatLng(33.7036, 72.9785),
    LatLng(33.567997728, 72.635997456),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latlng[i],
        infoWindow: InfoWindow(
          title: 'Real Cool Place',
          snippet: '5 star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polylines.add(Polyline(
          color: Colors.blue, polylineId: PolylineId('1'), points: latlng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PolyLne'),
      ),
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
    );
  }
}
