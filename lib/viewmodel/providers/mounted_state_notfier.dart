import 'package:flutter/material.dart';

class MountedStateNotifer extends ChangeNotifier {
  bool _mounted = false;

  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_mounted) {
      super.notifyListeners();
    }
  }
}
