import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpMethods {
  static void openScr(BuildContext context, scr) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => scr,
        ));
  }

  static void openScrNoBack(BuildContext context, scr) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => scr,
        ),
        (Route<dynamic> route) => false);
  }
}
