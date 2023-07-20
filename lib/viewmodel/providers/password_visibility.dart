import 'package:flutter/material.dart';

class VisibilityNotifier extends ChangeNotifier {
  bool passwordtoggle = true;
  bool confirmtoggle = true;

  void visibility(String type) {
    if (type == 'password') {
      passwordtoggle = !passwordtoggle;
      notifyListeners();
    } else {
      confirmtoggle = !confirmtoggle;
      notifyListeners();
    }
  }
}
