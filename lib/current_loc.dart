import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen1 extends StatefulWidget {
  const GetUserCurrentLocationScreen1({super.key});

  @override
  State<GetUserCurrentLocationScreen1> createState() =>
      _GetUserCurrentLocationScreen1State();
}

class _GetUserCurrentLocationScreen1State
    extends State<GetUserCurrentLocationScreen1> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  Set<Marker> markers = {};
  loadData() async {
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));

    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        infoWindow: const InfoWindow(title: 'Current Location'),
        position: LatLng(position.latitude, position.longitude)));

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Current Location'),
        ),
        body: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey,
          onPressed: () async {},
          label: const Text("Current Location"),
          icon: const Icon(Icons.location_history_rounded),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
