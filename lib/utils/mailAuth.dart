import 'package:firebase_auth/firebase_auth.dart';

class mailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> register(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user?.uid;
    } catch (error) {
      print("Registration error: $error");
      return null;
    }
  }

  // Sign in with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user?.uid;
    } catch (error) {
      print("Sign-in error: $error");
      return null;
    }
  }
}
