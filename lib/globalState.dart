import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  final AppUser _user = AppUser();

  AppUser get user => _user;

  void notify() {
    notifyListeners();
  }
}
