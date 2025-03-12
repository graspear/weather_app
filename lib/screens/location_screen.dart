import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(
    13.0843,
    80.2705,
  ); // Default location (San Francisco)

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onTap,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 10.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("selected"),
                  position: _selectedLocation,
                ),
              },
            ),
          ),
          ElevatedButton(
            onPressed: _confirmLocation,
            child: Text("Confirm Location"),
          ),
        ],
      ),
    );
  }
}
