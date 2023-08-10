// Page IMPORTS
import 'package:entrego/pages/homeEP/formEP.dart';

import '../pages/choicePg.dart';
import 'package:flutter/material.dart';

import '../pages/homeEP/homeEP.dart';
import '../pages/homeEP/navbarEP.dart';
import '../pages/homeINV/homeINV.dart';
import '../pages/homeINV/navbarINV.dart';
import '../pages/login.dart';

import '../pages/FirstPage.dart';
import '../pages/select.dart';
import '../pages/choicePg2.dart';
import '../pages/choicePg.dart';
import '../pages/homeEP/ideapage.dart';

class MyRoutes {
  static String initialPage = "/";
  static String homeINVPage = "/homeINV";
  static String homeEPPage = "/homeEP";
  static String loginpage = "/login";
  static String invSignupPage = "/signup";
  static String choicePage = "/choose";
  static String choice2Page = "/choose2";
  static String selectPage = "/signup/select";
  static String ideapage = "/homeINV/ideas";
  static String formForEP = "/signup/select/choose2/formForEP";


  Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      // initialPage: (context) => const FirstPage(),
      initialPage: (context) => homeEP(),
      ideapage: (context) => ProductDetailsPage(),
      homeEPPage: (context) => const homeEP(),
      homeINVPage: (context) => const homeINV(),
      loginpage: (context) => const login(),
      choicePage: (context) => const choice(),
      choice2Page: (context) => const choice2(),
      selectPage: (context) => const select(),
      formForEP: (context) =>  formEP(),
      

    };
  }
}
