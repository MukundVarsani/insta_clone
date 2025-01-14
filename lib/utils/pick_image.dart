import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();

  try {
    XFile? _file = await _imagepicker.pickImage(source: source);
    if (_file != null) {
      return _file.readAsBytes();
    }
    print("No image is selected");
  } catch (e) {
    print("$e");
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger
      .of(context)
      .showSnackBar(SnackBar(content: Text(content),
  )
  );
  }