import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatlangToAddress extends StatefulWidget {
  const ConvertLatlangToAddress({super.key});

  @override
  State<ConvertLatlangToAddress> createState() =>
      _ConvertLatlangToAddressState();
}

class _ConvertLatlangToAddressState extends State<ConvertLatlangToAddress> {
  String stAddress = '', stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(52.2165157, 6.9437819);
              // final coordinates = new Coordinates(33.6992, 72.9744);

              setState(() {
                stAddress = '${locations.last.longitude.toString()} '
                    ' ${locations.last.latitude.toString()}';

                stAdd = '${placemarks.reversed.last.country.toString()} '
                    ' ${placemarks.reversed.last.administrativeArea.toString()}';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Center(child: Text('Convert'))),
            ),
          )
        ],
      ),
    );
  }
}
