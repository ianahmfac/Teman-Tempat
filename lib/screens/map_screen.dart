import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:teman_tempat/helpers/api_key.dart';
import 'package:teman_tempat/models/place_location.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;
  final String appBarTitle;

  MapScreen(
      {@required this.location,
      this.isSelecting = false,
      this.appBarTitle = "Pilih Melalui Peta"});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String token = ApiKey.MAPBOX_API_KEY;
  LatLng _pickedLocation;

  _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void initState() {
    super.initState();
    _pickedLocation =
        LatLng(widget.location.latitude, widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: widget.isSelecting
            ? [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                )
              ]
            : null,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _pickedLocation,
          zoom: 16.0,
          interactive: true,
          onTap: widget.isSelecting
              ? (point) {
                  _selectLocation(point);
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/ianahmfac/ckkz8fajc1o4717ocjzryw3hj/tiles/256/{z}/{x}/{y}@2x?access_token=$token",
            additionalOptions: {
              "accessToken": token,
              "id": "mapbox.mapbox-streets-v8"
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _pickedLocation,
                builder: (ctx) => Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
