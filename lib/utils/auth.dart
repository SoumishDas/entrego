//importing neccessary packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/homeEP.dart';

class AuthState {
  //contains signup backend
  final FirebaseAuth auth = FirebaseAuth.instance;

  void init(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
        Navigator.pushNamed(context, "/homeEP");
      }
    });
  }

  Future<void> signIn(BuildContext context) async {
    final GoogleSignIn gSignIn = GoogleSignIn(); //google sign in request
    final GoogleSignInAccount? gSignInAcc = await gSignIn.signIn();

    if (gSignInAcc != null) {
      final GoogleSignInAuthentication gSignInAuth =
          await gSignInAcc.authentication;
      final AuthCredential authCred = GoogleAuthProvider.credential(
          idToken: gSignInAuth.idToken, accessToken: gSignInAuth.accessToken);

      UserCredential result = await auth.signInWithCredential(authCred);
      User? user = result.user;
      if (user != null) {
        print(user.displayName);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeEP()));
      }
    }
  }
}
