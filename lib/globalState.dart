import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  final AppUser _user = AppUser();

  AppUser get user => _user;

  EntrepreneurIdea _idea =
      EntrepreneurIdea(entrepreneurId: "Dd5qgesekdgZR6R21WRzVwSBTB42");

  EntrepreneurIdea get idea => _idea;

  void notify() {
    notifyListeners();
  }
}
