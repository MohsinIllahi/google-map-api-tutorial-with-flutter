import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1234';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDsNZttpgw0A4bXqfcdRkwmPWTAV4ElVi8";
    String type = '(regions)';
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Google search Places Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Search for places',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _controller.clear();
                    },
                  )),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(
                              _placeList[index]["description"]);

                          print(locations.last.longitude);
                          print(locations.last.latitude);
                        },
                        title: Text(_placeList[index]["description"]),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
