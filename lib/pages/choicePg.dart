import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // Set up your logic to populate tagList based on input data
    // For example, you can use a function that fetches tag data from a source
    tagList = fetchTagsFromInput(); // Replace this with your logic

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 242, 242, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Company'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Capital'),
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
                      decoration: InputDecoration(
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
    );
  }
}

// Replace this function with your logic to fetch tag data from input
List<String> fetchTagsFromInput() {
  // Example: Fetch tags from an API, database, or any other source
  return [
    'Tag 1',
    'Tag 2',
    'Tag 3',
    'Tag 4',
    'Tag 5'
  ]; // Replace with your tag data
}
