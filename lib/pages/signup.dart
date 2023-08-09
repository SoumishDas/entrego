import 'dart:ffi';

import 'package:flutter/material.dart';
import '../utils/MyRoutes.dart';
import '../utils/auth.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String name = "";
  String pw = "";

  bool htext = true;
  bool onChanged = false;
  final _formKey = GlobalKey<FormState>();

  Color green = const Color.fromRGBO(43, 98, 102, 1);
  Color black = const Color.fromRGBO(14, 5, 15, 1);
  Color blueBlack = const Color.fromRGBO(23, 11, 59, 1);

  void hideText() {
    if (htext == true) {
      htext = false;
    } else if (htext == false) {
      htext = true;
    }
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        onChanged = true;
      });

      await Future.delayed(const Duration(milliseconds: 2000));
      // await Navigator.pushNamed(context, MyRoutes.);
      setState(() {
        onChanged = false;
      });
    }
  }

  final AuthState signUp = AuthState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/BG.jpg"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 125,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    margin: const EdgeInsets.only(
                        top: 50, bottom: 80, left: 23, right: 23),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 35.0,
                                ),
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 30),
                                child: Column(
                                  children: [
                                    TextFormField(
                                        decoration: const InputDecoration(
                                          label: Text("Email"),
                                          hintText: "Enter Email ID",
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Email cannot be empty";
                                          }
                                          return null;
                                        }),
                                    const SizedBox(height: 5),
                                    TextFormField(
                                      obscureText: htext,
                                      decoration: const InputDecoration(
                                        label: Text("Password"),
                                        hintText: "Enter Password",
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          pw = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password cannot be empty";
                                        } else if (value.length < 8) {
                                          return "Password should have a minimum length of 8 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    onChanged
                                        ? const SizedBox(height: 48)
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              FloatingActionButton.small(
                                                  backgroundColor: green,
                                                  child: htext
                                                      ? const Icon(
                                                          Icons.visibility)
                                                      : const Icon(
                                                          Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      hideText();
                                                    });
                                                  }),
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        moveToHome(context);
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        width: onChanged ? 50 : 150,
                                        height: onChanged ? 50 : 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: onChanged
                                                ? Colors.green
                                                : green,
                                            borderRadius: BorderRadius.circular(
                                                onChanged ? 50 : 8)),
                                        child: onChanged
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                "Start",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ElevatedButton.icon(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        icon: const Icon(
                                          Icons.g_mobiledata,
                                          color: Color.fromRGBO(43, 98, 102, 1),
                                        ),
                                        label: const Text(
                                          "Log In with Google",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromRGBO(
                                                  43, 98, 102, 1)),
                                        )),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
