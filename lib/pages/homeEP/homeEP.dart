import 'package:flutter/material.dart';
import '../homeEP/navbarEP.dart';

class homeEP extends StatefulWidget {
  const homeEP({super.key});

  @override
  State<homeEP> createState() => _homeEPState();
}

class _homeEPState extends State<homeEP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Project Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tagline: Revolutionizing the Industry',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor eros ac euismod.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Technologies Used:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('AI')),
                      Chip(label: Text('Machine Learning')),
                      Chip(label: Text('IoT')),
                      // Add more chips as needed
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Capital Received: \$500,000',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Capital Left to Receive: \$500,000',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Equity Given: 10%',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tags:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Innovation')),
                      Chip(label: Text('Technology')),
                      Chip(label: Text('Startup')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavEP(),
    );
  }
}
