import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class formEP extends StatefulWidget {
  @override
  _formEPState createState() => _formEPState();
}

class _formEPState extends State<formEP> {
  String _productName = '';
  String _shortDescription = '';
  String _longDescription = '';
  double _capitalRequired = 0.0;
  double _equity = 0.0;
  String _contactInfo = '';
  List<String> selectedTags = [];
  String searchQuery = '';
  List<String> tagList = ['alpha', 'beta', 'gamma', 'delta'];

  File? _selectedImageFile;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
    }
  }

  List<String> get filteredTags {
    return tagList
        .where((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Publish Your Idea',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                onChanged: (value) {
                  setState(() {
                    _productName = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Short Description'),
                onChanged: (value) {
                  setState(() {
                    _shortDescription = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Long Description'),
                onChanged: (value) {
                  setState(() {
                    _longDescription = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Capital Required'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _capitalRequired = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Equity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _equity = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Contact Information'),
                onChanged: (value) {
                  setState(() {
                    _contactInfo = value;
                  });
                },
              ),
              SizedBox(height: 20),
              _selectedImageFile == null
                  ? Text('No Image Selected')
                  : Image.file(
                      _selectedImageFile!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _selectImage,
                child: Text('Select Image'),
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
                    height: 150,
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic to save the product details
                    },
                    child: Text('Save Product'),
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
