import 'package:firebase_auth/firebase_auth.dart';
import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> register(BuildContext context, email, String password) async {
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
          await auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            checkAppUser(context, value);
          });
          ;
          print("Logged in: $email");
        } else {
          // Handle other FirebaseAuthException cases
          print("Error: ${e.code}");
        }
      }
    }
  }
}
