import 'package:entrego/utils/auth.dart';
import 'package:flutter/material.dart';
import '../utils/MyRoutes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool onChanged = false;
  Color purple = const Color.fromRGBO(52, 25, 72, 1);
  Color black = const Color.fromRGBO(14, 5, 15, 1);
  AuthState authState = AuthState();

  moveTo2ndPg(BuildContext context) async {
    setState(() {
      onChanged = true;
    });
    var myroutes = MyRoutes();
    await Future.delayed(const Duration(milliseconds: 2000));
    await Navigator.pushNamed(context, myroutes.signupPage);
    setState(() {
      onChanged = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 5, 15, 1),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG.jpg"),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 250,
              ),
              InkWell(
                onTap: () {
                  moveTo2ndPg(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  moveTo2ndPg(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
