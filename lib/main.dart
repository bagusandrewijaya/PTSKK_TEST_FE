import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notesapps/pages/loginregister/loginPages.dart';
import 'package:notesapps/pages/loginregister/registerpages.dart';
import 'pages/homescreen.dart';
import 'pages/loadingscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
