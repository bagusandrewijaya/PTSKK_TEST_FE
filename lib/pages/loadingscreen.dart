import 'package:flutter/material.dart';
import 'package:notesapps/class/classusers.dart';
import 'package:notesapps/pages/homescreen.dart';
import 'package:notesapps/pages/loginregister/loginPages.dart';
import 'package:notesapps/pages/loginregister/registerpages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

int data = 0;

class _LoadingScreenState extends State<LoadingScreen> {
  late SharedPreferences sharedPreferences;
  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString('username') != null) {
        setState(() {
          Userclass.username = sharedPreferences.getString('username')!;
        });
        await Future.delayed(Duration(seconds: 7));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else {
        await Future.delayed(Duration(seconds: 7));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PagesLogin(),
            ));
      }
    } catch (e) {}
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffefd3d7), Color(0xfff8edeb)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "NOTES APPS",
              style: TextStyle(
                  color: Color(0xff8e9aaf),
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  fontFamily: 'aminahf'),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
