import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teman_tempat/shared/theme.dart';

class ImageInput extends StatefulWidget {
  final Function onImageSaved;

  ImageInput({@required this.onImageSaved});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDirectory =
        await getApplicationDocumentsDirectory(); // Untuk mengambil direktori app
    final fileName = basename(
        imageFile.path); // Untuk menjadikan path image sebagai filename
    final savedImage = await _storedImage.copy(
        "${appDirectory.path}/$fileName"); // Menyalin gambar yang telah diambil ke direktori yang ditentukan
    widget.onImageSaved(savedImage);
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(imageFile.path);
    });

    widget.onImageSaved(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : Text("No Image Previewed", textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _buildModalPickingImage(context);
            },
            icon: Icon(Icons.add_a_photo_outlined),
            label: Text("Pilih Gambar"),
          ),
        ),
      ],
    );
  }

  Future _buildModalPickingImage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Pilih tindakan",
                    style: titleStyle,
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Ambil dengan kamera"),
                onTap: () {
                  Navigator.of(context).pop();
                  takePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Pilih dari galeri"),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
