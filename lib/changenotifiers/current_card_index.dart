import 'package:flutter/material.dart';

class CurrentCardIndex extends ChangeNotifier {
  int _currentCardIndex = 0;

  int get value => _currentCardIndex;

  setCurrentCardIndex(int index) {
    _currentCardIndex = index;
    notifyListeners();
  }

  updateCurrentCardIndex(int index) {
    _currentCardIndex = index;
  }
}