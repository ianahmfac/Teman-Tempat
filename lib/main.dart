import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teman_tempat/providers/place_provider.dart';
import 'package:teman_tempat/screens/home_page.dart';
import 'package:teman_tempat/shared/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: mainColor,
          accentColor: accentColor,
        ),
        home: HomePage(),
      ),
    );
  }
}
