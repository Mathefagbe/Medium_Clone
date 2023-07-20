import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Mode _thememode = Mode.light;
  Mode get thememode => _thememode;

  void switchTheme(Mode typemode) {
    _thememode = typemode;
    notifyListeners();
  }
}

enum Mode { light, dark, system }
