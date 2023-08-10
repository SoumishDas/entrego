import 'dart:ui';

import 'package:entrego/globalState.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    EntrepreneurIdea idea = baseState.idea;

    baseState.idea.getIdea().then(
          (value) => setState(() => (idea = baseState.idea)),
        );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250, // Adjust the image container's height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(idea.imgLink),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      ...idea.techUsed.map((tech) => Chip(label: Text(tech))),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
