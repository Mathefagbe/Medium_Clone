import 'package:flutter/material.dart';

class NavigateViewModel extends ChangeNotifier {
  int currentindex = 0;

  void getindex(int newindex) {
    currentindex = newindex;
    notifyListeners();
  }
}
