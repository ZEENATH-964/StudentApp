import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_project/add.dart';
import 'package:student_project/details.dart';
import 'package:student_project/edit.dart';
import 'package:student_project/functions/db_functions.dart';
import 'package:student_project/model/std_model.dart';
import 'package:student_project/screen1/login.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String search = '';
  List<StudentModel> searchList = [];

  studentUpdate() {
    getAllStudent();
    searchList = studentListNotifier.value
        .where((std) => std.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
             setState(() {
               search=value;
               studentUpdate();
             });
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => Add()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (BuildContext, List<StudentModel> studentlist,
                    Widget? child) {
                  return search.isNotEmpty
                      ? searchList.isEmpty
                          ? Center(
                              child: Text('result not found'),
                            )
                          : _buildStdentList(searchList)
                      : _buildStdentList(studentlist);
                }),
          ),
        ],
      ),
    ));
  }

  Widget _buildStdentList(List<StudentModel> student) {
    return student.isEmpty
        ? Center(
            child: Text('no students are available'),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              final data = student[index];

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => studentDetails(
                        name: data.name,
                        age: data.age,
                        cls: data.cls,
                        address: data.address,
                        image: data.image,
                      ),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditScreen(
                                      name: data.name,
                                      age: data.age,
                                      cls: data.cls,
                                      address: data.address,
                                      index: index,
                                      image: data.image)));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          deleteStudent(index);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                leading: CircleAvatar(
                  backgroundImage: data.image != null
                      ? FileImage(File(data.image),)
                      : AssetImage('images/image.png'),
                ),
                title: Text(
                  data.name,
                  style: TextStyle(color: Colors.amber),
                ),
              );
            },
            itemCount: student.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('log', false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => Login()), (Route) => false);
  }
}
