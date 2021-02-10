import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:teman_tempat/models/place_location.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  MapScreen({@required this.location, this.isSelecting = false});
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
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16.0,
          interactive: true,
          onTap: (point) {
            _selectLocation(point);
          },
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/ianahmfac/ckkz8fajc1o4717ocjzryw3hj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaWFuYWhtZmFjIiwiYSI6ImNramt1d21weDA0MDcycW4wNWR6dnZwcjgifQ.XIjkZvTEBbbGtqBhMVzMMg",
              additionalOptions: {
                "accessToken": token,
                "id": "mapbox.mapbox-streets-v8"
              }),
          MarkerLayerOptions(
            markers: [
              Marker(
                  width: 80.0,
                  height: 80.0,
                  point: _pickedLocation == null
                      ? LatLng(
                          widget.location.latitude, widget.location.longitude)
                      : _pickedLocation,
                  builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      )),
            ],
          ),
        ],
      ),
    );
  }
}
