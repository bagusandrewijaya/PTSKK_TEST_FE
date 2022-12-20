import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapps/class/classusers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];
  String nama = "";
  String bearer = "";
  @override
  void initState() {
    insert();
    fetchuser();
    super.initState();
  }

  insert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');

    setState(() {
      nama = name!;
    });
  }

  fetchuser() async {
    String url = "https://randomuser.me/api/?results=50";

    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    var items = jsonDecode(res.body)['results'];
    if (res.statusCode == 200) {
      setState(() {
        users = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    return Scaffold(body: getBody());
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff)),
      ));
    }
    // return ListView.builder(
    //     itemCount: users.length,
    //     itemBuilder: (context, index) {
    //       return getCard(users[index]);
    //     });

    return GridView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: users.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.30,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 2),
        itemBuilder: ((context, index) {
          return getCard(users[index]);
        }));
  }

  Widget getCard(item) {
    var fullName = item['name']['first'] + " ";
    item['name']['last'];
    var email = item['email'];
    var profileUrl = item['picture']['large'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40 / 2),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(profileUrl))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullName,
                        style: TextStyle(fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
