import 'package:flutter/cupertino.dart';

class HomeTabProvider extends ChangeNotifier {

  HomeTabProvider();

  int _navIndex = 0;
  int get navIndex => _navIndex;

  void setNavIndex(int newIndex) {
    _navIndex = newIndex;
  }
}