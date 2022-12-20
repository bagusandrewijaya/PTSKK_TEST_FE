import 'dart:convert';
import 'dart:math';
import 'package:notesapps/class/classusers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapps/pages/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:notesapps/pages/loginregister/registerpages.dart';

import '../model/popup.dart';

class PagesLogin extends StatefulWidget {
  const PagesLogin({super.key});

  @override
  State<PagesLogin> createState() => _PagesLoginState();
}

class _PagesLoginState extends State<PagesLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    final prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({"email": email.text, "password": password.text});
    var res = await http.post(
        Uri.parse("https://itchy-seal-bonnet.cyclic.app/user/login"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var response = jsonDecode(res.body);
    if (res.statusCode == 201) {
      setState(() {
        prefs.setString("username", response['rows'][0]['username']);
        String? stringValue = prefs.getString('username');
        Userclass.username = stringValue!;
        print(stringValue);
      });

      print(response['rows'][0]['username']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } else if (res.statusCode == 401) {
      messengger(context, response['message'],
          Color.fromARGB(255, 220, 90, 107), "assets/images/noentry.png");
    } else if (res.statusCode == 404) {
      messengger(context, response['message'],
          Color.fromARGB(255, 220, 90, 107), "assets/images/noentry.png");
    }
  }

//
  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: scheight - 700,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                color: Color.fromARGB(255, 119, 178, 215)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'aminahf',
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Apps",
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'aminahf',
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 186, 179, 157),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Password"),
            ),
          ),
          SizedBox(
            height: scheight - 700,
          ),
          ElevatedButton(
              onPressed: () {
                login();
              },
              child: Container(
                width: 250,
                height: 50,
                child: Center(
                  child: Text("SIGNIN"),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPages(),
                    ));
              },
              child: Container(
                width: 250,
                height: 50,
                child: Center(
                  child: Text("SIGNUP"),
                ),
              )),
        ],
      )),
    );
  }
}
