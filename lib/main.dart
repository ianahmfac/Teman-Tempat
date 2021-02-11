import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:teman_tempat/providers/place_provider.dart';
import 'package:teman_tempat/screens/add_place_screen.dart';
import 'package:teman_tempat/screens/home_screen.dart';
import 'package:teman_tempat/shared/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceProvider(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            primarySwatch: mainColor,
            accentColor: accentColor,
          ),
          title: "Teman Tempat",
          home: HomeScreen(),
          routes: {
            AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          },
        ),
      ),
    );
  }
}
