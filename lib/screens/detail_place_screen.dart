import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teman_tempat/models/place.dart';
import 'package:teman_tempat/providers/place_provider.dart';
import 'package:teman_tempat/screens/map_screen.dart';
import 'package:teman_tempat/shared/theme.dart';

class DetailPlaceScreen extends StatelessWidget {
  static const routeName = "detail-place";
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final Place place =
        Provider.of<PlaceProvider>(context, listen: false).findById(id);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            height: size.height * 0.35,
            width: double.infinity,
          ),
          _buildInfo(place, context),
        ],
      ),
    );
  }

  Widget _buildInfo(Place place, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              place.title,
              style: titleStyle,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.red),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    place.location.address,
                    style: titleStyle.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    location: place.location,
                    appBarTitle: place.title,
                  ),
                ));
              },
              icon: Icon(Icons.map),
              label: Text("Lihat pada Peta"),
            ),
          ],
        ),
      ),
    );
  }
}
