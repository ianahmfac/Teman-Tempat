import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teman_tempat/models/place_location.dart';
import 'package:teman_tempat/providers/place_provider.dart';
import 'package:teman_tempat/shared/theme.dart';
import 'package:teman_tempat/widgets/image_input.dart';
import 'package:teman_tempat/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _imagePicked;
  PlaceLocation _locationPicked;

  void _selectImage(File imagePicked) {
    _imagePicked = imagePicked;
  }

  void _selectLocation(double latitude, double longitude) {
    _locationPicked = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _imagePicked == null ||
        _locationPicked == null) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text("Kesalahan"),
                content: Text(
                    "Nama tempat, gambar dan lokasi tidak boleh dikosongkan"),
                actions: [
                  CupertinoButton(
                    child: Text("Tutup"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false)
        .addNewPlace(_titleController.text, _imagePicked, _locationPicked);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Tempat"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildUserInput(),
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Nama Tempat",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ImageInput(onImageSaved: _selectImage),
            SizedBox(height: 16),
            LocationInput(_selectLocation),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return TextButton(
      onPressed: _savePlace,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text(
              "Tambahkan",
              style: titleStyle,
            ),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: accentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          )),
    );
  }
}
