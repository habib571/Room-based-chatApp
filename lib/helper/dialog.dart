import 'package:flutter/material.dart';
import 'package:revi/constant/colors.dart';

class Dialogs {
  static void showSnackbar(BuildContext contxt, String msg) {
    ScaffoldMessenger.of(contxt).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: themecolor.withOpacity(0.8) ,
        behavior: SnackBarBehavior.floating));
  }
}