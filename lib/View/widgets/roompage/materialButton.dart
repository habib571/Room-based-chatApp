import 'package:flutter/material.dart';

class Materialbutton extends StatelessWidget {
 final String text;
 final void Function() onPressed;
  
  const Materialbutton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     Container(
      margin: const EdgeInsets.all(20),
    child: MaterialButton(
      padding:const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed:onPressed,
     color: Colors.green,
      child: Text(text),  
     ),);
  }
}



