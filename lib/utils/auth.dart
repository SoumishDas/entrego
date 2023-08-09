//importing neccessary packages
import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../pages/homeEP.dart';

class AuthState {
  //contains methods for user sign in and authentication
  final FirebaseAuth auth = FirebaseAuth.instance; //initialize auth state

  void init(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
        Navigator.pushNamed(context, "/homeEP");
      }
    });
  }

  //handle google sign in
  Future<void> signIn(BuildContext context) async {
    final GoogleSignIn gSignIn = GoogleSignIn(); //google sign in request
    final GoogleSignInAccount? gSignInAcc = await gSignIn.signIn();

    BaseState baseState = Provider.of<BaseState>(context);

    if (gSignInAcc != null) {
      final GoogleSignInAuthentication gSignInAuth =
          await gSignInAcc.authentication;
      final AuthCredential authCred = GoogleAuthProvider.credential(
          idToken: gSignInAuth.idToken, accessToken: gSignInAuth.accessToken);

      UserCredential result = await auth.signInWithCredential(authCred);
      User? user = result.user;
      if (user != null) {
        final QuerySnapshot res = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: user.uid)
            .get(); //firebase query to get information about user
        final List<DocumentSnapshot> documents = res.docs;
        if (documents.isEmpty) {
          // Update data on the server for new user
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'nickname': user.displayName,
            'photoUrl': user.photoURL,
            'id': user.uid,
          });
          baseState.user.getUser(user.uid).then((value) {
            if (value == true) {
              print(user.displayName);
              if (baseState.user.isInvestor) {
                Navigator.pushNamed(context, MyRoutes.homeINVPage);
              } else {
                Navigator.pushNamed(context, MyRoutes.homeEPPage);
              }
            } else {
              Navigator.pushNamed(context, MyRoutes.choicePage);
            }
          });
        }
      }
    }
  }
}
