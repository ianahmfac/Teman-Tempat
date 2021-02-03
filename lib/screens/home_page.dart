import 'package:flutter/material.dart';
import 'package:teman_tempat/shared/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teman Tempat"),
      ),
      body: Center(
        child: Text(
          "TEMAN TEMPAT",
          style: titleStyle,
        ),
      ),
    );
  }
}
