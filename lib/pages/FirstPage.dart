import 'package:entrego/pages/login.dart';
import 'package:entrego/utils/auth.dart';
import 'package:flutter/material.dart';
import '../utils/MyRoutes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  AuthState authState = AuthState();

  moveTo2ndPg(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 16));
    await Navigator.pushNamed(context, MyRoutes.loginpage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: 1000,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/BG.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 125,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: Card(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 80,
                        left: 23,
                        right: 23,
                      ),
                      elevation: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                "Entrego",
                                style: TextStyle(
                                  color: Color.fromRGBO(43, 98, 102, 1),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50.0,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      MyRoutes
                                          .loginpage // Navigate to the login page
                                      );
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35,
                                  color: Color.fromRGBO(43, 98, 102, 1),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
