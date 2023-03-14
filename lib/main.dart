import 'package:flutter/material.dart';
import 'package:googlemap/convert_latlang_to_address.dart';
import 'package:googlemap/current_loc.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/custom_marker_screen.dart';
import 'package:googlemap/google_places_api.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/network_image_marker.dart';
import 'package:googlemap/polygone_screen.dart';
import 'package:googlemap/polyline.dart';
import 'package:googlemap/style_googlemap_screen.dart';
import 'package:googlemap/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StyleGoogleMapScreen(),
    );
  }
}
