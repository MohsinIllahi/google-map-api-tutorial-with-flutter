import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );

  @override
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'The title of the marker')),
    Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(33.738045, 73.084488),
        infoWindow: InfoWindow(title: 'e-11 islamabd')),
    Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(35.6762, 139.6503),
        infoWindow: InfoWindow(title: 'Jappan Demo Location')),
    Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: 'Demo Location')),
  ];

  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 14),
          ));
          setState(() {});
        },
      ),
    );
  }
}
