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
      // backgroundColor: const Color.fromRGBO(14, 5, 15, 1),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 10.0,
                  //     spreadRadius: 2,
                  //     offset: Offset(
                  //       5,
                  //       5,
                  //     ),
                  //   )
                  // ],
                ),
                child: const Text(
                  "Entrego",
                  style: TextStyle(
                      color: Color.fromRGBO(43, 98, 102, 1),
                      fontSize: 70,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      moveTo2ndPg(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 9),
                      decoration: BoxDecoration(
                          // boxShadow: [20, 21, 22, 22],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.forward_rounded,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
