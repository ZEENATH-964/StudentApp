import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_project/home.dart';
import 'package:student_project/screen1/login.dart';
                                                                          
  class Splash extends StatefulWidget {
    const Splash({super.key});      
             
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _checkLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
        // child: Image.asset('images/school1.jpeg'),
      ),
       
      
      ),
    );
  }

Future<void>_checkLogin(BuildContext context)async{
  // await Future.delayed(Duration(seconds: 5));
  final SharedPreferences pref=await SharedPreferences.getInstance();
 final isLoggedIn=pref.getBool('isLoggedIn') ?? false;

 if(isLoggedIn){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MyHome()));
}else{
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Login()));
}
}
}

      
                              


