import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseState extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  int get auth => _auth;

  void increment() {
    _count++;
    notifyListeners();
  }
}
