import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_project/model/std_model.dart';
import 'package:student_project/screen1/splash.dart';



void main()async{
WidgetsFlutterBinding.ensureInitialized();
Hive.registerAdapter(StudentModelAdapter());

await Hive.initFlutter();
  runApp(myapp());
}
class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),
    );
  }
}