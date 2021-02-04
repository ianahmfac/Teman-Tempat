import 'dart:io';

import 'package:flutter/material.dart';
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
  }
}
