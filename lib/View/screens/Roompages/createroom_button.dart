

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';



class createroombutton extends StatelessWidget { 
 final void Function() onPressed;
  
   createroombutton (
    {Key? key,
    required this.onPressed,
     }) : super(key: key);


int num = 0;
@override
 Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: onPressed,
      
      tooltip: 'create a new room',
      child: const Icon(Icons.group_add_rounded),
    );

     
  }
} 
