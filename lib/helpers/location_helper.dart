import 'dart:convert';

import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    "pk.eyJ1IjoiaWFuYWhtZmFjIiwiYSI6ImNramt1d21weDA0MDcycW4wNWR6dnZwcjgifQ.XIjkZvTEBbbGtqBhMVzMMg";

class LocationHelper {
  static String generatePreviewImage({double latitude, double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,12/500x300?access_token=$MAPBOX_API_KEY";
  }

  static Future<String> getLocationName(
      double latitude, double longitude) async {
    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$MAPBOX_API_KEY";
    final response = await http.get(url);
    String locationName =
        json.decode(response.body)["features"][0]["place_name"];
    return locationName;
  }
}
