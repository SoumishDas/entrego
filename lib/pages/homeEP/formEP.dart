import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class formEP extends StatefulWidget {
  const formEP({super.key});

  @override
  State<formEP> createState() => _formEPState();
}

class _formEPState extends State<formEP> {
  String productName = '';
  String productDesc = '';
  XFile? selectedImg;
  Future<void> selectImg() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImg = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
