import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  final AppUser _user = AppUser();

  AppUser get user => _user;

  final EntrepreneurIdea _idea =
      EntrepreneurIdea(entrepreneurId: "y9TGHbMSkeRl1WZeep1rlaHDxbC3");

  EntrepreneurIdea get idea => _idea;

  void notify() {
    notifyListeners();
  }
}
