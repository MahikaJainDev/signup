

import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  bool hidePwd = true;

  setPassword() {
    if (hidePwd) {
      hidePwd = false;
    } else {
      hidePwd = true;
    }
    notifyListeners();
  }
}
