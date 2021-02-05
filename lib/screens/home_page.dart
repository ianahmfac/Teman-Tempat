import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:teman_tempat/providers/place_provider.dart';
import 'package:teman_tempat/screens/add_place_screen.dart';
import 'package:teman_tempat/shared/theme.dart';
import 'package:teman_tempat/widgets/place_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teman Tempat"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlaceProvider>(context, listen: false).fetchPlaces(),
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.waiting)
                ? SpinKitFadingCircle(
                    color: accentColor,
                  )
                : Consumer<PlaceProvider>(
                    child: Center(
                      child: Text(
                        "Empty Data",
                        style: titleStyle,
                      ),
                    ),
                    builder: (context, place, child) {
                      return (place.places.isEmpty)
                          ? child
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: place.places.length,
                              itemBuilder: (BuildContext context, int index) {
                                final currentPlace = place.places[index];
                                return PlaceItem(currentPlace: currentPlace);
                              },
                            );
                    },
                  ),
      ),
    );
  }
}
