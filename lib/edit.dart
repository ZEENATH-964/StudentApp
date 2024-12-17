import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/functions/db_functions.dart';
import 'package:student_project/model/std_model.dart';

class EditScreen extends StatefulWidget {
  
  EditScreen({
    super.key,
    required this.index,
    required this.name,
    required this.age,
    required this.cls,
    required this.address,
    
    required this.image,
  });
final int index;
  final String name;
  final String age;
  final String cls;
  final String address;
  final dynamic image;


  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController nameEditController=TextEditingController();
  final TextEditingController ageEditController=TextEditingController();
  final TextEditingController clsEditController=TextEditingController();
  final TextEditingController addressEditController=TextEditingController();
  File? _selectedImage1;

  @override
  void initState() {
   
nameEditController.text=widget.name;
ageEditController.text=widget.age;
clsEditController.text=widget.cls;
addressEditController.text=widget.address;
_selectedImage1=widget.image!=null?File(widget.image):null;
 super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: _selectedImage1 != null
                        ? FileImage(_selectedImage1!)
                        : AssetImage('images/image.png') ,
                  ),
                  TextButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Text('Add Avatar'),
                  ),
                  Gap(10),
                  TextField(
                    controller: nameEditController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(10),
                  TextField(
                    controller: ageEditController,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(10),
                  TextField(
                    controller: clsEditController,
                    decoration: InputDecoration(
                      hintText: 'Class',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(10),
                  TextField(
                    controller: addressEditController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Gap(10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      onEditBtn();
                    },
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onEditBtn() {
    final ename = nameEditController.text.trim();
    final eage = ageEditController.text.trim();
    final ecls = clsEditController.text.trim();
    final eaddress = addressEditController.text.trim();
    final image1 = _selectedImage1?.path ?? '';

    if (ename.isEmpty || eage.isEmpty || ecls.isEmpty || eaddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final updatedStudent = StudentModel(
      name: ename,
      age: eage,
      cls: ecls,
      address: eaddress,
      image: image1,
    );

    editStudent(updatedStudent, widget.index);
    Navigator.of(context).pop();
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage1 = File(pickedImage.path);
      });
    }
  }



  
}
