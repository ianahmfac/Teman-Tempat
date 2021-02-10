const MAPBOX_API_KEY =
    "pk.eyJ1IjoiaWFuYWhtZmFjIiwiYSI6ImNramt1d21weDA0MDcycW4wNWR6dnZwcjgifQ.XIjkZvTEBbbGtqBhMVzMMg";

const MAPQUEST_API_KEY = "N944hrDybXzVuSnLAKNAtAsgavhvF4be";

class LocationHelper {
  static String generatePreviewImage({double latitude, double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,12/500x300?access_token=$MAPBOX_API_KEY";
    // return "https://www.mapquestapi.com/staticmap/v5/map?locations=$latitude,$longitude&size=600,400@2x&key=$MAPQUEST_API_KEY";
  }
}
