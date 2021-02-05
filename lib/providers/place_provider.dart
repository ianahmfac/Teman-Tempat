import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teman_tempat/helpers/db_helper.dart';
import 'package:teman_tempat/models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  void addNewPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert("PLACES", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": image.path,
    });
  }

  Future fetchPlaces() async {
    final List<Map<String, dynamic>> dataPlaces = await DBHelper.read("PLACES");

    _places = dataPlaces
        .map((place) => Place(
              id: place["id"],
              title: place["title"],
              image: File(place["image"]),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
