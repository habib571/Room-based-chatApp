
import'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({ 
    Key? key  , 
    required this.buttonName ,
    required this.ontap , 
    required this.textcolor , 
    required this.bgcolor
  }):super(key: key); 
  final String buttonName ; 
  final Function ontap ; 
  final Color textcolor ; 
  final Color bgcolor ; 

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 55, 
      width: double.infinity, 
      decoration:  BoxDecoration(
        color: bgcolor , 
        borderRadius:  BorderRadius.circular(18) ,

      ), 
      child: TextButton(
      onPressed: () {
        ontap();
        }, 
      style: ButtonStyle(  
        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12) , 
     
        ), 
        child: Text( 
          buttonName , 
          style:  TextStyle(color: textcolor,
          fontSize: 16,
          fontWeight: FontWeight.bold ,
  
  ), 


        ),


      ),
       
       );





    
  }
}