import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() =>
      _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  late Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );

  @override
  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'The title of the marker')),
    // Marker(
    //     markerId: MarkerId('SomeId'),
    //     position: LatLng(33.738045, 73.084488),
    //     infoWindow: InfoWindow(title: 'e-11 islamabd')),
  ];

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              getUserCurrentLocation().then((value) async {
                print('my current location');
                print('${value.longitude} ' ' ${value.latitude}');

                _marker.clear();

                _marker.add(
                  Marker(
                      markerId: MarkerId('2'),
                      position: LatLng(value.longitude, value.latitude),
                      infoWindow: InfoWindow(title: 'My current Location')),
                );
                CameraPosition cameraPosition = CameraPosition(
                    zoom: 14, target: LatLng(value.longitude, value.latitude));
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {});
              });
            },
            child: const Icon(Icons.local_activity)),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('Error' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
