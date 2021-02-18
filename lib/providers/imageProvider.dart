import 'dart:io';

import 'package:flutter/material.dart';

class ImageProvider extends ChangeNotifier {
  var image;

  Future setImage(File file) async {
    this.image = file;
    this.notifyListeners();
  }
}
