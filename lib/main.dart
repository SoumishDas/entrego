// Based on https://dartpad.dev/?id=d57c6c898dabb8c6fb41018588b8cf73
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Imports from UTIL
import 'utils/MyRoutes.dart';
import 'globalState.dart';

const Color darkBlue = Color.fromARGB(252, 18, 32, 47);

const messageLimit = 50;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e, st) {
    print(e);
    print(st);
  }

  // The first step to using Firebase is to configure it so that our code can
  // find the Firebase project on the servers. This is not a security risk, as
  // explained here: https://stackoverflow.com/a/37484053
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // We sign the user in anonymously, meaning they get a user ID without having
  // to provide credentials. While this doesn't allow us to identify the user,
  // this would, for example, still allow us to associate data in the database
  // with each user.
  // await FirebaseAuth.instance.signInAnonymously();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DateFormat formatter = DateFormat('MM/dd HH:mm:SS');

  final MyRoutes routes = MyRoutes();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BaseState(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.quicksand().fontFamily,
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        //Routes of Pages
        // initialRoute: MyRoutes.homepage,
        routes: routes.getRoutes(context),
      ),
    );
  }
}
