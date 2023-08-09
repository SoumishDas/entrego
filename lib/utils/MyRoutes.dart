// Page IMPORTS
import '../pages/choicePg.dart';
import 'package:flutter/material.dart';

import '../pages/homeEP.dart';
import '../pages/homeINV.dart';
import '../pages/login.dart';

import '../pages/FirstPage.dart';

class MyRoutes {
  static String initialPage = "/";
  static String homeINVPage = "/homeINV";
  static String homeEPPage = "/homeEP";
  static String loginpage = "/login";
  static String signupPage = "/signup";
  static String choicePage = "/choose";

  Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      initialPage: (context) => const choice(),
      homeEPPage: (context) => const HomeEP(),
      homeINVPage: (context) => const HomeINV(),
      loginpage: (context) => const login(),
      //signupPage: (context) => const signup(),
      //choicePage : (context) => ;
    };
  }
}
