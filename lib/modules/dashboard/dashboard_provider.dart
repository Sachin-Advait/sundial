import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int selectedIndex = 0;

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
