import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:teman_tempat/helpers/location_helper.dart';
import 'package:teman_tempat/models/place_location.dart';
import 'package:teman_tempat/screens/map_screen.dart';
import 'package:teman_tempat/shared/theme.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  bool _isLoadImage = false;
  bool _isNavigateToMap = false;

  Future _getCurrentLocation() async {
    setState(() {
      _isLoadImage = true;
      _previewImageUrl = "";
    });
    final LocationData locationData = await Location().getLocation();
    setState(() {
      _isLoadImage = false;
      _previewImageUrl = LocationHelper.generatePreviewImage(
          latitude: locationData.latitude, longitude: locationData.longitude);
    });
  }

  Future _selectOnMap() async {
    setState(() {
      _isNavigateToMap = true;
    });
    final LocationData locationData = await Location().getLocation();
    final LatLng selectMap = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MapScreen(
        location: PlaceLocation(
            latitude: locationData.latitude, longitude: locationData.longitude),
        isSelecting: true,
      ),
    ));
    if (selectMap == null) {
      return;
    }
    setState(() {
      _isNavigateToMap = false;
      _previewImageUrl = LocationHelper.generatePreviewImage(
        latitude: selectMap.latitude,
        longitude: selectMap.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: (_previewImageUrl == null)
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : (_isLoadImage)
                  ? SpinKitFadingCircle(
                      color: accentColor,
                    )
                  : Image.network(
                      _previewImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Lokasi Saat Ini"),
              onPressed: _getCurrentLocation,
            ),
            (_isNavigateToMap)
                ? SpinKitFadingCircle(
                    color: accentColor,
                  )
                : TextButton.icon(
                    icon: Icon(Icons.map),
                    label: Text("Pilih Melalui Map"),
                    onPressed: _selectOnMap,
                  ),
          ],
        ),
      ],
    );
  }
}
