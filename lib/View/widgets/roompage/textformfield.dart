
import 'package:flutter/material.dart';


class CustomTextForm extends StatelessWidget {

 final String hinttext;
 //final String labeltext;
 //final IconData icondata ;
 final TextEditingController? mycontroller;
 final String? Function(String?)? valid;

  const CustomTextForm ({Key? key, required this.hinttext,  /*required this.icondata, */required this.mycontroller, required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField( 
    
             autovalidateMode: AutovalidateMode.always,
             validator: valid,
              controller:mycontroller,
              decoration: InputDecoration( 
              
                hintText: hinttext,
                hintStyle: const TextStyle(fontSize: 14),
               // label: Text(labeltext),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                //suffixIcon: Icon(icondata),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  
                )
              ),
            );
 
  }
}