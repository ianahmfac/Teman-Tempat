import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teman_tempat/helpers/db_helper.dart';
import 'package:teman_tempat/helpers/location_helper.dart';
import 'package:teman_tempat/models/place.dart';
import 'package:teman_tempat/models/place_location.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future addNewPlace(String title, File image, PlaceLocation location) async {
    final String locationName = await LocationHelper.getLocationName(
        location.latitude, location.longitude);
    final PlaceLocation updateLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: locationName);

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updateLocation,
    );
    _places.add(newPlace);

    notifyListeners();
    DBHelper.insert("PLACES", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_latitude": newPlace.location.latitude,
      "loc_longitude": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
  }

  Future fetchPlaces() async {
    final List<Map<String, dynamic>> dataPlaces = await DBHelper.read("PLACES");

    _places = dataPlaces
        .map((place) => Place(
              id: place["id"],
              title: place["title"],
              image: File(place["image"]),
              location: PlaceLocation(
                latitude: place["loc_latitude"],
                longitude: place["loc_longitude"],
                address: place["address"],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
