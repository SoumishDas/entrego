import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:entrego/utils/tags.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:provider/provider.dart';

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
  List<String> selectedTech = [];
  String searchQuery = '';
  String searchQuery_tech = '';
  List<String> tagList = tags.genreTags;
  List<String> techList = tags.techTags;

  EntrepreneurIdea entrepreneurIdea = EntrepreneurIdea();

  File? _selectedImageFile;

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
    }
  }

  Future<String> _uploadImage() async {
    if (_selectedImageFile == null) return "";

    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');

    final UploadTask uploadTask = storageReference.putFile(_selectedImageFile!);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print('Image uploaded');
    });

    // Get the download URL of the uploaded image
    final String imageUrl = await taskSnapshot.ref.getDownloadURL();
    print('Download URL: $imageUrl');
    return imageUrl;
  }

  List<String> get filteredTags {
    return tagList
        .where((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  List<String> get filteredTech {
    return techList
        .where((tech) =>
            tech.toLowerCase().contains(searchQuery_tech.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/BG.jpg"),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Publish Your Idea',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          hintText: 'Enter Product Name...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _productName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Short Description',
                          hintText: 'Add a short description...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _shortDescription = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Long Description',
                          hintText: 'Add a long description....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _longDescription = value;
                          });
                        },
                        maxLines: null,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Capital Required',
                          hintText: 'Enter the capital required...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _capitalRequired = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Equity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _equity = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Contact Information',
                          hintText: 'Enter your phone number...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _contactInfo = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _selectedImageFile == null
                          ? const Text('No Image Selected')
                          : Image.file(
                              _selectedImageFile!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _selectImage,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(43, 98, 102, 1),
                            foregroundColor: Colors.white),
                        child: const Text(
                          'Select Image',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Tags:', style: TextStyle(fontSize: 16)),
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
                            height: 150,
                            child: SingleChildScrollView(
                              child: Column(
                                children: filteredTags.map((tag) {
                                  final isSelected = selectedTags.contains(tag);

                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
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
                          const SizedBox(height: 10),
                          const Text('Tech Tags:',
                              style: TextStyle(fontSize: 16)),
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
                                    labelText: 'Search for tech tags',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              Container(
                                height: 150,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: filteredTech.map((tech) {
                                      final isSelected =
                                          selectedTech.contains(tech);

                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 8.0),
                                        title: Text(tech),
                                        trailing: Icon(isSelected
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank),
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedTech.remove(tech);
                                            } else {
                                              selectedTech.add(tech);
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
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(43, 98, 102, 1),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  if (_productName.isEmpty ||
                                      _shortDescription.isEmpty ||
                                      _longDescription.isEmpty ||
                                      _capitalRequired == 0.0 ||
                                      _equity == 0.0 ||
                                      _contactInfo.isEmpty ||
                                      selectedTags.isEmpty ||
                                      selectedTech.isEmpty ||
                                      _selectedImageFile == null) {
                                    // Display a snackbar or an alert to notify the user about missing fields
                                    showErrorMessage("Please Fill All Fields");
                                    return;
                                  } else if (_equity >= 100) {
                                    showErrorMessage(
                                        "Please give Valid Equity Percentage");
                                    return;
                                  }

                                  // Add logic to save the product details
                                  entrepreneurIdea.entrepreneurId =
                                      baseState.user.uid;
                                  entrepreneurIdea.bIdeaDescription =
                                      _longDescription;
                                  entrepreneurIdea.sIdeaDescription =
                                      _shortDescription;
                                  entrepreneurIdea.fundingNeeded =
                                      _capitalRequired;
                                  entrepreneurIdea.equityOffered = _equity;
                                  entrepreneurIdea.name = _productName;
                                  entrepreneurIdea.contactInfo = _contactInfo;
                                  entrepreneurIdea.tags = selectedTags;
                                  entrepreneurIdea.techUsed = selectedTech;

                                  _uploadImage().then((value) {
                                    entrepreneurIdea.imgLink = value;
                                    entrepreneurIdea.saveIdea().then(
                                      (value) {
                                        if (value == true) {
                                          Navigator.pushNamed(
                                              context, MyRoutes.homeEPPage);
                                        } else {
                                          showErrorMessage(
                                              "Idea Could Not Be Saved");
                                          return;
                                        }
                                      },
                                    );
                                  });
                                },
                                child: const Text(
                                  'Save Product',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
