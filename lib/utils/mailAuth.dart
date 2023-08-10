import 'package:firebase_auth/firebase_auth.dart';
import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class mailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void checkAppUser(BuildContext context, UserCredential userCred) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);
    baseState.user.email = userCred.user!.email!;
    baseState.user.uid = userCred.user!.uid;
    baseState.user.getUser(userCred.user!.uid).then((value) {
      if (value == true) {
        //print(userCred.user.displayName);
        if (baseState.user.isInvestor) {
          Navigator.pushNamed(context, MyRoutes.homeINVPage);
        } else {
          Navigator.pushNamed(context, MyRoutes.homeEPPage);
        }
      } else {
        Navigator.pushNamed(context, MyRoutes.selectPage);
      }
    });
  }

  Future<String> register(BuildContext context, email, String password) async {
    UserCredential userCred;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        checkAppUser(context, value);
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Account already exists, try to log in
          String text = await auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            checkAppUser(context, value);
            return "";
          }).onError((error, stackTrace) {
            return "Wrong Password";
          });

          print("Logged in: $email");
          return text;
        } else {
          // Handle other FirebaseAuthException cases
          print("Error: ${e.code}");
          return e.message!;
        }
      }
    }
    return "";
  }
}
