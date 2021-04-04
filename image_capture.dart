import 'dart:io';

import 'package:dukan_app/widgets/image/uploader.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  String picId;
  ImageCapture(this.picId);
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () async {
                  await _pickImage(ImageSource.camera);
                }),
            // SizedBox(
            //   width: 50,
            // ),
            IconButton(
                icon: Icon(Icons.file_present),
                onPressed: () async {
                  await _pickImage(ImageSource.gallery);
                }),
          ],
        ),
      ),
      body: ListView(
        children: [
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: [
                FlatButton(
                  onPressed: _cropImage,
                  child: Icon(Icons.crop),
                ),
                FlatButton(
                  onPressed: _clear,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            Uploader(_imageFile, widget.picId),
          ]
        ],
      ),
    );
  }
}
