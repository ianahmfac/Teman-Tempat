import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:teman_tempat/models/place_location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  MapScreen(
      {this.location =
          const PlaceLocation(latitude: -6.200000, longitude: 106.816666),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String token =
      "pk.eyJ1IjoiaWFuYWhtZmFjIiwiYSI6ImNramt1d21weDA0MDcycW4wNWR6dnZwcjgifQ.XIjkZvTEBbbGtqBhMVzMMg";
  LatLng _pickedLocation;

  _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Melalui Peta"),
        actions: [
          widget.isSelecting
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                )
              : null,
        ],
      ),
      body: MapboxMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
        accessToken: token,
        onMapClick: widget.isSelecting
            ? (point, coordinates) {
                _selectLocation(coordinates);
              }
            : null,
        styleString: MapboxStyles.LIGHT,
      ),
    );
  }
}
