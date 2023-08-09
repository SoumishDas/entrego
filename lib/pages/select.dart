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
            ElevatedButton(onPressed: () {}, child: Text("Investor")),
            ElevatedButton(onPressed: () {}, child: Text("Entrepreneur")),
          ],
        ),
      ),
    );
  }
}
