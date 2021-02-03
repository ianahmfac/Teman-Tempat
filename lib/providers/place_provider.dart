import 'package:flutter/material.dart';
import 'package:teman_tempat/models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];
}
