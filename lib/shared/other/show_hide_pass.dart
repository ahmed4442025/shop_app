import 'package:flutter/material.dart';

class ShowHidePass {
  final IconData _showIcon = Icons.visibility;
  final IconData _hideIcon = Icons.visibility_off;
  bool izPass = true;
  late IconData icon;

  ShowHidePass() {
    icon = _showIcon;
  }

  void changeShow() {
    izPass = !izPass;
    icon = izPass ? _showIcon : _hideIcon;
  }
}
