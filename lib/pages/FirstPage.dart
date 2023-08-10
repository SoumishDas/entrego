import 'package:entrego/utils/auth.dart';
import 'package:flutter/material.dart';
import '../utils/MyRoutes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Color purple = const Color.fromRGBO(52, 25, 72, 1);
  Color black = const Color.fromRGBO(14, 5, 15, 1);
  AuthState authState = AuthState();

  moveTo2ndPg(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 16));
    await Navigator.pushNamed(context, MyRoutes.loginpage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "Entrego",
                  style: TextStyle(
                    color: Color.fromRGBO(43, 98, 102, 1),
                    fontSize: 70,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Welcome to Entrego!\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec urna et elit tincidunt finibus.",
                style: TextStyle(
                  color: Color.fromRGBO(43, 98, 102, 1),
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  moveTo2ndPg(context);
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(43, 98, 102, 1),
                  size: 30,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xfafafa),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
