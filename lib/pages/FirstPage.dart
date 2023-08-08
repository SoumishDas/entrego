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

  AuthState authState = AuthState();

  moveTo2ndPg(BuildContext context) async {
    setState(() {
      onChanged = true;
    });

    await Future.delayed(const Duration(milliseconds: 2000));
    await Navigator.pushNamed(context, MyRoutes.loginpage);
    setState(() {
      onChanged = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                moveTo2ndPg(context);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: onChanged ? 50 : 100,
                height: onChanged ? 50 : 40,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(onChanged ? 50 : 8)),
                child: onChanged
                    ? const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    : const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
