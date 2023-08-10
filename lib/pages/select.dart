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
        child: Align(
          child: Container(
            height: 1000,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/BG.jpg"),
                    fit: BoxFit.cover)),
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "I am an ...",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.choicePage);
                    },
                    child: const Text("Investor"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          43, 98, 102, 1), // Set the background color
                      foregroundColor: Colors.white, // Set the text color
                      textStyle: TextStyle(
                        fontSize: 25, // Set the text size
                        fontWeight: FontWeight.bold,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(150, 50),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.choice2Page);
                    },
                    child: const Text("Entrepreneur"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          43, 98, 102, 1), // Set the background color
                      foregroundColor: Colors.white, // Set the text color
                      textStyle: TextStyle(
                        fontSize: 25, // Set the text size
                        fontWeight: FontWeight.bold,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(150, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
