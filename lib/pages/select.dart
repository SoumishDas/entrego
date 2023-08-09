import 'package:entrego/utils/MyRoutes.dart';
import 'package:flutter/material.dart';

class select extends StatefulWidget {
  const select({super.key});

  @override
  State<select> createState() => _selectState();
}

class _selectState extends State<select> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("I am an ..."),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.invSignupPage);
                },
                child: const Text("Investor")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.choicePage);
                },
                child: const Text("Entrepreneur")),
          ],
        ),
      ),
    );
  }
}
