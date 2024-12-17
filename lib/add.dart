import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/functions/db_functions.dart';

import 'package:student_project/model/std_model.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
 final nameController=TextEditingController();
  final ageController=TextEditingController();
 final clsController=TextEditingController();
 final addressController=TextEditingController();
  File?_selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
           children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: _selectedImage!=null
              ?FileImage(_selectedImage!)
              :AssetImage('images/image.png')
               ),
            Gap(10),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.white
              ),
              onPressed: (){
                  gallery();
              }, child: Text('Add Avatar')),
              Gap(10),
               TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
               ),
                   Gap(10),
               TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age',
                ),
                keyboardType: TextInputType.number,
               ),
               Gap(10),
               TextField(
                keyboardType: TextInputType.number,
                controller: clsController,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(),
                  hintText: 'Class',
                ),
                
               ),
               Gap(10),
               TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
               ),
               Gap(20),
               ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: Colors.white),
                onPressed: (){
                  addButton();
                }, child: Text('Submit')),
                
           ], 
          ),
        ),
      ),
    );
  }

  Future<void>addButton()async{
   final name= nameController.text;
   final age= ageController.text;
  final cls=  clsController.text;
   final address= addressController.text;
    if(name.isEmpty||age.isEmpty||cls.isEmpty||address.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please fill all field')));
    }else{
     final student=StudentModel(name: name,
      age: age, 
      cls: cls,
       address: address,
        image: _selectedImage?.path??'',
        );
        addStudent(student);
        Navigator.of(context).pop();
    }
  }
  Future<void>gallery()async{
    final image=await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage=File(image!.path);
    });
  }
}