// Page IMPORTS
import 'package:entrego/pages/homeEP/formEP.dart';
import 'package:entrego/pages/homeINV/investPg.dart';

import '../pages/choicePg.dart';
import 'package:flutter/material.dart';

import '../pages/homeEP/homeEP.dart';

import '../pages/homeINV/homeINV.dart';

import '../pages/login.dart';

import '../pages/FirstPage.dart';
import '../pages/select.dart';
import '../pages/choicePg2.dart';

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
  static String ideapage_EP = "/homeEP/ideas";
  static String formForEP = "/signup/select/choose2/formForEP";
  static String InvestPage = '/homeINV/invest';

  Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      // initialPage: (context) => const FirstPage(),
      initialPage: (context) => const FirstPage(),
      ideapage: (context) => ProductDetailsPage(),
      ideapage_EP: (context) => ProductDetailsPage(),
      homeEPPage: (context) => const homeEP(),
      homeINVPage: (context) => const homeINV(),
      loginpage: (context) => const login(),
      choicePage: (context) => const choice(),
      choice2Page: (context) => const choice2(),
      selectPage: (context) => const select(),
      formForEP: (context) => formEP(),
      InvestPage: (context) => const investPg(),
    };
  }
}
