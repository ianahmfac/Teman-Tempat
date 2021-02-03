import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teman_tempat/models/place_location.dart';

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
