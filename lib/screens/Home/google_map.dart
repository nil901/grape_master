

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class MapWithMarkers extends StatefulWidget {
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map with Markers'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Initial map center
          zoom: 10.0,
        ),
        onTap: (LatLng position) {
          // Add a marker on tap
          addMarker(position);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Calculate and display the area
          double area = calculateArea(markers.map((marker) => marker.position).toList());
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Calculated Area'),
                content: Text('Area: $area square meters'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.calculate),
      ),
    );
  }

  void addMarker(LatLng position) {
    setState(() {
      if (markers.length < 3) {
        markers.add(Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ));
      }
    });
  }

  double calculateArea(List<LatLng> positions) {
    // Use a simple formula to calculate the area of a triangle (Heron's formula)
    double a = LatLngDistance(positions[0], positions[1]);
    double b = LatLngDistance(positions[1], positions[2]);
    double c = LatLngDistance(positions[2], positions[0]);

    double s = (a + b + c) / 2;
    return math.sqrt(s * (s - a) * (s - b) * (s - c));
  }
 
 double LatLngDistance(LatLng point1, LatLng point2) {
  const double radius = 6371000.0; // Earth's radius in meters

  double radians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  double lat1 = radians(point1.latitude);
  double lon1 = radians(point1.longitude);
  double lat2 = radians(point2.latitude);
  double lon2 = radians(point2.longitude);

  double dlat = lat2 - lat1;
  double dlon = lon2 - lon1;

  double a = math.sin(dlat / 2) * math.sin(dlat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) * math.sin(dlon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  return radius * c;
}

}

