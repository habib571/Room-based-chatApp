import 'package:flutter/material.dart';

class DrawCard extends StatelessWidget {
  const DrawCard ({
    super.key ,
    required this.title , 
    required this.icon ,
    required this.ontap
    });
  final String title ; 
  final Widget icon ; 
  final Function() ontap ;
  @override
  Widget build(BuildContext context) {
    return ListTile( 
        title: Text(title,), 
        leading: icon , 
        onTap: ontap

    ) ;
  }
}