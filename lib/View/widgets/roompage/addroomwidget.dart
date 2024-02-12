import 'package:flutter/material.dart';

class AddRoomCard extends StatelessWidget {
  const AddRoomCard({
    super.key  , 
    required this.ontap
    
    });

  final  Function ontap ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), 
          color: Colors.white
         ),
        child: Center( 
          child: Center(
            child: InkWell( 
              onTap: () { 
                  ontap() ; 
              },
              child: CircleAvatar( 
                radius: 35, 
                backgroundColor: Colors.grey.shade400,
                child: const Icon(
                  Icons.add ,
                  size:35 ,  
                  color: Colors.black,
                  ),
              ),
            ),
          ),
    
        ),
      ),
    ) ;
  }
}