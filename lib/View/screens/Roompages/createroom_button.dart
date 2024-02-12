

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:revi/constant/colors.dart';



class Createroombutton extends StatelessWidget { 
 final void Function() onPressed;
  
   const Createroombutton (
    {Key? key,
    required this.onPressed,
     }) : super(key: key);



@override
 Widget build(BuildContext context) {
    return  FloatingActionButton( 
      backgroundColor: themecolor,
      onPressed: onPressed,
      
      tooltip: 'create a new room',
      child: const Icon(Icons.group_add_rounded),
    );

     
  }
} 
