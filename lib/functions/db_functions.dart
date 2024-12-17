import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_project/model/std_model.dart';

ValueNotifier<List<StudentModel>>studentListNotifier=ValueNotifier([]);
Future<void>addStudent(StudentModel value)async{
  final studentdb=await Hive.openBox<StudentModel>('student_db');
  await studentdb.add(value);
  getAllStudent();
}





Future<void>getAllStudent()async{
  final studentdb=await Hive.openBox<StudentModel>('student_db');
 studentListNotifier.value.clear();
 studentListNotifier.value.addAll(studentdb.values);
studentListNotifier.notifyListeners();
}

Future<void>deleteStudent(int index)async{
  final studentdb=await Hive.openBox<StudentModel>('student_db');
  studentdb.deleteAt(index);
  getAllStudent();
}

Future<void>editStudent(StudentModel value,int index)async{
  final studentdb=await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentdb.values);
  studentdb.putAt(index, value);
  getAllStudent();
}