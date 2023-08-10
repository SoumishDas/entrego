import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class choice2 extends StatefulWidget {
  const choice2({Key? key}) : super(key: key);

  @override
  State<choice2> createState() => _choice2State();
}

class _choice2State extends State<choice2> {
  String firstName = "";
  String lastName = "";

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);
    // Set up your logic to populate tagList based on input data
    // For example, you can use a function that fetches tag data from a source

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 242, 242, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG.jpg"), fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.9,
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
                    offset: Offset(0, 3))
              ]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter your first name...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter your last name...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(43, 98, 102, 1),
                          foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        onPressed: () {
                          baseState.user.firstName = firstName;
                          baseState.user.lastName = lastName;

                          baseState.user.isInvestor = false;

                          baseState.user.addUser().then(
                            (value) {
                              if (value == true) {
                                Navigator.pushNamed(
                                    context, MyRoutes.formForEP);
                              } else {
                                print("ERROR ADDING USER");
                              }
                            },
                          );
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
