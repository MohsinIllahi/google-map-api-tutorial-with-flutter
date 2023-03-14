import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => NetworkImageMarkerState();
}

class NetworkImageMarkerState extends State<NetworkImageMarker> {
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
    loadData();
  }

  loadData() async {
    for (var i = 0; i < _latlng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://media-exp1.licdn.com/dms/image/D4D03AQEvDc1X_86eJA/profile-displayphoto-shrink_800_800/0/1668878226686?e=1674691200&v=beta&t=ziWYuw1ZMqttl1LUD5WbacnnqjoGAdT-tOrwoFQtrS4');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List? resizedImageMarker = byteData!.buffer.asUint8List();

      _markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(resizedImageMarker!),
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: 'This is car ' + i.toString()),
        position: _latlng[i],
      ));
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Network Image Marker'),
      ),
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
    );
  }
}
