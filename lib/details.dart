import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_project/functions/db_functions.dart';

class studentDetails extends StatelessWidget {
  String name;
  String age;
  String cls;
  String address;
  dynamic image;
   studentDetails({
    super.key,
     required this.name,
   required this.age,
   required this.cls,
   required this.address,
   required this.image });

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
          
            child: Column(
             
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: image!=null?FileImage(File(image)):AssetImage('images/image.png'),
                ),
              
              
          Row(children: [Text('Name : ',style: TextStyle(fontWeight: FontWeight.bold),),Text('$name')],),
              Gap(10),
              Row(children: [Text('Age : ',style: TextStyle(fontWeight: FontWeight.bold)),Text('$age')],),
              Gap(10),
              Row(children: [Text('Class : ',style: TextStyle(fontWeight: FontWeight.bold)),Text('$cls')],),
              Gap(10),
              Row(children: [Text('Address : ',style: TextStyle(fontWeight: FontWeight.bold)),Text('$address')],),
          
                  
                
                  Gap(10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.white),
                    onPressed: (){Navigator.of(context).pop();}, child: Text('Back')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}