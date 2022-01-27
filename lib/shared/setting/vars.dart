import 'package:flutter/material.dart';

class Vars{

  static late Color pryClr ;

  Vars.init(BuildContext context){
    pryClr = Theme.of(context).primaryColor;
  }

  static const String imagesPath = 'assets/images';
  // static const Color introColor = Colors.amber;
}