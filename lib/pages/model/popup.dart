import 'package:flutter/material.dart';

void messengger(BuildContext context, String text, Color code, String image) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: BoxDecoration(
            color: code,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Row(
          children: [
            Image.asset(
              "$image",
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Text("$text")
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
