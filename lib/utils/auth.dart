//importing neccessary packages
import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AuthState {
  //contains methods for user sign in and authentication
  final FirebaseAuth auth = FirebaseAuth.instance; //initialize auth state

  // Handle google sign in
  Future<bool> signIn(BuildContext context) async {
    final GoogleSignIn gSignIn = GoogleSignIn(); //google sign in request
    final GoogleSignInAccount? gSignInAcc = await gSignIn.signIn();

    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    if (gSignInAcc != null) {
      final GoogleSignInAuthentication gSignInAuth =
          await gSignInAcc.authentication;
      final AuthCredential authCred = GoogleAuthProvider.credential(
          idToken: gSignInAuth.idToken, accessToken: gSignInAuth.accessToken);

      UserCredential result = await auth.signInWithCredential(authCred);
      User? user = result.user;
      if (user != null) {
        print("YESSSSSSSSSSSSSSSSSSSSSSSSSS");
        
        
        
          // Update data on the server for new user
          
          print("YEZZZZZZZZZZZZZZZZZ");
          baseState.user.email = user.email!;
          baseState.user.getUser(user.uid).then((value) {
            if (value == true) {
              
              if (baseState.user.isInvestor) {
                print("@@@@@@@@@@@@@@@@@");
                Navigator.pushNamed(context, MyRoutes.homeINVPage);
              } else {
                print("&&&&&&&&&&&&&&&&&&&");
                Navigator.pushNamed(context, MyRoutes.homeEPPage);
              }
            } else {
              print("!!!!!!!!!!!!!!!!!!!!!");
              baseState.user.uid=user.uid;
              Navigator.pushNamed(context, MyRoutes.selectPage);
            }
            return true;
          });
        }
      
    }else{
      print("ERRORRRRRRRRRRRR");
      return false;
    }
    print("F2222222222222F223333333333FFFFFFFFFFFFFF24242424FFFFFFFFFFF");
    return true;
  }
}
