import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class investPg extends StatefulWidget {
  const investPg({super.key});

  @override
  State<investPg> createState() => _investPgState();
}

class _investPgState extends State<investPg> {
  // void openWhatsApp() async {
  //   final phoneNumber = '1234567890'; // Replace with the desired phone number
  //   final url = 'https://wa.me/$phoneNumber/';

  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch WhatsApp.';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), // Add some spacing at the top
            ElevatedButton(
              // onPressed: openWhatsApp,
              onPressed: () {},
              child: Text('Open WhatsApp'),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the button here
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the button here
                    },
                    child: Text('Send'),
                  ),
                  // Add any content you want to display here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
