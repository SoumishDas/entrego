import 'package:entrego/globalState.dart';
import 'package:entrego/pages/homeEP/navbarEP.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homeINV/navbarINV.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  EntrepreneurIdea idea = EntrepreneurIdea();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final BaseState baseState =
          Provider.of<BaseState>(context, listen: false);

      baseState.idea.getIdea().then(
            (value) => setState(() => (idea = baseState.idea)),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    return Scaffold(
      body: Container(
        width: 1000,
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/BG.jpg",
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(idea.imgLink), // Replace with your image
                    fit: BoxFit.cover,
                  ),
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
                height: 250,
              ),
              Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        idea.sIdeaDescription,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        idea.bIdeaDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Contacts:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        idea.contactInfo,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Capital Required: \$ ${idea.fundingNeeded}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Equity Offered: ${idea.equityOffered}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Technologies Used:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          ...idea.techUsed
                              .map((tech) => Chip(label: Text(tech))),
                          // Add more chips as needed
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tags:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          ...idea.tags.map((tag) => Chip(label: Text(tag))),
                          // Add more chips as needed
                        ],
                      ),
                      baseState.user.isInvestor
                          ? ElevatedButton(
                              child: const Text("Invest"),
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                fixedSize: Size(100, 45),
                                backgroundColor: Color.fromRGBO(
                                    43, 98, 102, 1), // Set the background color
                                foregroundColor:
                                    Colors.white, // Set the text color
                                textStyle: TextStyle(
                                  fontSize: 20, // Set the text size
                                  fontWeight: FontWeight.w500,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.InvestPage);
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          baseState.user.isInvestor ? const NavINV() : const NavEP(),
    );
  }
}
