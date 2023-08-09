import 'package:flutter/material.dart';
import '../homeEP/navbarEP.dart';

class homeEP extends StatefulWidget {
  const homeEP({super.key});

  @override
  State<homeEP> createState() => _homeEPState();
}

class Product {
  final String name;
  final String description;
  final int numInvestors;
  final double totalCapital;

  Product({
    required this.name,
    required this.description,
    required this.numInvestors,
    required this.totalCapital,
  });
}

class _homeEPState extends State<homeEP> {
  final product = Product(
      name: "name",
      description: "description",
      numInvestors: 234,
      totalCapital: 45678);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text('Number of Investors: ${product.numInvestors}'),
              Text(
                  'Total Capital Gained: \$${product.totalCapital.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavEP(),
    );
  }
}
