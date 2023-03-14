import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => StyleGoogleMapScreenState();
}

class StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[];

  List<LatLng> _latlng = [
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/silver_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Map Theme'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/silver_theme.json')
                                .then((string) => {
                                      value.setMapStyle(string),
                                    });
                          });
                        },
                        child: Text('Silver')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/retro_theme.json')
                                .then((string) => {
                                      value.setMapStyle(string),
                                    });
                          });
                        },
                        child: Text('Retro')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/night_theme.json')
                                .then((string) => {
                                      value.setMapStyle(string),
                                    });
                          });
                        },
                        child: Text('Night')),
                  ]),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapTheme);
              _controller.complete(controller);
            }),
      ),
    );
  }
}
