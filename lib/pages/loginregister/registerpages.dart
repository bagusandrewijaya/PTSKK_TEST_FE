import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapps/pages/loginregister/loginPages.dart';
import 'package:http/http.dart' as http;

import '../model/popup.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  TextEditingController username = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void registration() async {
    if (username.text != "" &&
        emailcontroller.text != "" &&
        password.text != "") {
      try {
        var body = jsonEncode({
          "username": username.text,
          "email": emailcontroller.text,
          "password": password.text
        });

        var res = await http.post(
            Uri.parse("https://itchy-seal-bonnet.cyclic.app/user/register"),
            headers: {"Content-Type": "application/json"},
            body: body);
        var response = jsonDecode(res.body);

        if (res.statusCode == 200) {
          messengger(context, "Succes Register",
              Color.fromARGB(255, 90, 220, 120), "assets/images/payment.png");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PagesLogin(),
              ));
        }
        if (res.statusCode == 201) {
          messengger(context, response['response']['code'],
              Color.fromARGB(255, 220, 90, 107), "assets/images/payment.png");
        }
      } catch (e) {}
    } else {
      messengger(context, "make sure all fields are not empty",
          Color.fromARGB(255, 220, 90, 107), "assets/images/noentry.png");
    }
  }

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
                      "Register",
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'aminahf',
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      " Account",
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
            width: scwidth - 100,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                hintText: "Username",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: 60,
            width: scwidth - 100,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: emailcontroller,
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
            width: scwidth - 100,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Password"),
            ),
          ),
          SizedBox(
            height: scheight / 10,
          ),
          ElevatedButton(
              onPressed: () {
                registration();
              },
              child: Container(
                width: 250,
                height: 50,
                child: Center(
                  child: Text("REGISTER"),
                ),
              )),
          SizedBox(
            height: 250,
          ),
        ],
      )),
    );
  }
}
