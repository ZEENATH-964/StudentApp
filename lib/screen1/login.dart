import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_project/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userNameController=TextEditingController();
  final _passwordController=TextEditingController();
  final _predefindUserName='zeenath';
  final _predefindPassword='zeenath123';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
       body: Container(
        color: Colors.white,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.asset('images/images2.jpeg'),),
              Gap(50),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText:"username",
                  border:OutlineInputBorder(),
                ),
              ),
              Gap(10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              Gap(10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white
                ),
                onPressed: (){_login(context);}, child: Text('login'))
            ],
           ),
         ),
       ), 
      ),
    );
  }

  Future<void>_login(BuildContext context)async{
    final _username=_userNameController.text;
    final _password=_passwordController.text;
    if(_username==_predefindUserName&& _password==_predefindPassword){
      final SharedPreferences pref=await SharedPreferences.getInstance();
      await pref.setBool('isLoggedIn', true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>MyHome() ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior:SnackBarBehavior.floating ,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        content: Text('invalid username or password')));
    }
  }
}