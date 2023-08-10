import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class choice extends StatefulWidget {
  const choice({Key? key}) : super(key: key);

  @override
  State<choice> createState() => _choiceState();
}

class _choiceState extends State<choice> {
  List<String> selectedTags = [];
  String searchQuery = '';
  List<String> tagList = []; // Initialize tagList as an empty list

  List<String> get filteredTags {
    return tagList
        .where((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  bool isInteger(String value) {
    final RegExp regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(value);
  }

  String firstName = "";
  String lastName = "";
  int capital = 0;

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);
    // Set up your logic to populate tagList based on input data
    // For example, you can use a function that fetches tag data from a source
    tagList = fetchTagsFromInput(); // Replace this with your logic

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 242, 242, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG.jpg"), fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
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
                      },
                    ),
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Capital',
                        hintText: 'Enter the capital required...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Capital cannot be empty";
                        } else if (!isInteger(value)) {
                          return "Capital has to be integer";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          capital = int.parse(value);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text('Tags:', style: TextStyle(fontSize: 16)),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            onChanged: (query) {
                              setState(() {
                                searchQuery = query;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Search for tags',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Container(
                          height: 150, // Adjust the height as needed
                          child: SingleChildScrollView(
                            child: Column(
                              children: filteredTags.map((tag) {
                                final isSelected = selectedTags.contains(tag);

                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  title: Text(tag),
                                  trailing: Icon(isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank),
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedTags.remove(tag);
                                      } else {
                                        selectedTags.add(tag);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Decreased spacing here
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(43, 98, 102, 1),
                              onPrimary: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            onPressed: () {
                              // Implement registration logic
                              baseState.user.capital = capital;
                              baseState.user.firstName = firstName;
                              baseState.user.lastName = lastName;
                              baseState.user.prefTags = selectedTags;
                              baseState.user.isInvestor = true;

                              baseState.user.addUser().then((value) {
                                if (value == true) {
                                  Navigator.pushNamed(
                                      context, MyRoutes.homeINVPage);
                                } else {
                                  print("ERROR ADDING USER");
                                }
                              });
                            },
                            child: Text('Register'),
                          ),
                        ),
                      ],
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

// Replace this function with your logic to fetch tag data from input
List<String> fetchTagsFromInput() {
  // Example: Fetch tags from an API, database, or any other source
  return tags.genreTags; // Replace with your tag data
}
