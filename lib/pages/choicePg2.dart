import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class choice2 extends StatefulWidget {
  const choice2({Key? key}) : super(key: key);

  @override
  State<choice2> createState() => _choice2State();
}

class _choice2State extends State<choice2> {
  List<String> selectedTags = [];
  String searchQuery = '';
  List<String> tagList = []; // Initialize tagList as an empty list

  List<String> get filteredTags {
    return tagList
        .where((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  String firstName = "";
  String lastName = "";

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);
    // Set up your logic to populate tagList based on input data
    // For example, you can use a function that fetches tag data from a source
    tagList = fetchTagsFromInput(); // Replace this with your logic

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 242, 242, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    }),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                ),
                SizedBox(height: 10),

                SizedBox(height: 10), // Decreased spacing here
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(43, 98, 102, 1),
                      foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    onPressed: () {
                      // Implement registration logic

                      baseState.user.firstName = firstName;
                      baseState.user.lastName = lastName;

                      baseState.user.isInvestor = false;

                      baseState.user.addUser().then(
                        (value) {
                          if (value == true) {
                            Navigator.pushNamed(context, MyRoutes.homeEPPage);
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
    );
  }
}

// Replace this function with your logic to fetch tag data from input
List<String> fetchTagsFromInput() {
  // Example: Fetch tags from an API, database, or any other source
  return tags.genreTags; // Replace with your tag data
}
