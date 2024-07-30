import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdp2/utils/global_colors.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({Key? key}) : super(key: key);

  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  LatLng _selectedLocation = LatLng(23.8377, 90.3579); // Default to MIST, Mirpur Cantonment, Dhaka
  final MapController _mapController = MapController();
  String _address = 'Tap on the map to select an address';
  final TextEditingController _typeAheadController = TextEditingController();

  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _address = '${placemark.name ?? ''}, ${placemark.thoroughfare ?? ''}, '
              '${placemark.subThoroughfare ?? ''}, ${placemark.locality ?? ''}, '
              '${placemark.subAdministrativeArea ?? ''}, ${placemark.administrativeArea ?? ''}, '
              '${placemark.country ?? ''}, ${placemark.postalCode ?? ''}';
        });
      } else {
        setState(() {
          _address = 'No address available';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Failed to get address';
      });
    }
  }

  Future<List<LocationSuggestion>> _getLocationSuggestions(String query) async {
    final Uri url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => LocationSuggestion.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: GlobalColors.mainColor,
        title: Text('Select Address'.tr, style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Search your address below',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TypeAheadField<LocationSuggestion>(

              suggestionsCallback: _getLocationSuggestions,
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.displayName),
                );
              },
              onSelected: (LocationSuggestion suggestion) async {
                LatLng position = LatLng(suggestion.lat, suggestion.lon);
                setState(() {
                  _selectedLocation = position;
                  _typeAheadController.text = suggestion.displayName;
                });
                _mapController.move(_selectedLocation, 17.0);
                await _updateAddress(_selectedLocation);
              },
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _selectedLocation,
                initialZoom: 17.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                  });
                  _updateAddress(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _selectedLocation,
                      child: Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_address),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back(result: _address);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class LocationSuggestion {
  final String displayName;
  final double lat;
  final double lon;

  LocationSuggestion({required this.displayName, required this.lat, required this.lon});

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) {
    return LocationSuggestion(
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
