
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';   







 class RoomCardBO extends StatelessWidget{
  const RoomCardBO( {super.key, 
  required this.height ,  
  required this.width ,
   required this.text,  
   required this.token  ,
   
  
  }
  );  
  
  final double height ;   
  final double width ;
  final String text ;  
  final String token ; 
  



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 15 ,horizontal: 50) ,
      child:
      InkWell(  
        onTap: () {
          
        },
        child :
       Container(
        height:  height,                                                       //____ ELEMENTS__________
        width:  width,
        decoration: BoxDecoration(
          color:Color.fromARGB(223, 24, 109, 88), 
          borderRadius: BorderRadius.circular(30),
        ), 
        child: InkWell(  
          
            
          
          onTap: (() {
             
          } ) , 

          child:  Column( 
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [   
           const  SizedBox(  
            height: 35,

            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children :[  
            const Text( 
               'Name:'  ,
               style: TextStyle( 
                fontSize: 20, 
                  fontWeight: FontWeight.bold 
               ),

            ) ,
           Text( 
             text , 
             style: const  TextStyle( 
              fontSize: 20, 
              fontWeight: FontWeight.bold ),
          ) 
           ]
          ) ,
        const SizedBox( 
          height: 20,
        ), 

        Row(  
          mainAxisAlignment: MainAxisAlignment.center,
          children :[ 
            const Text( 
              'Token:' , 
              style: TextStyle( 
                fontSize: 16 , 
                fontWeight: FontWeight.bold
               
              ),

            ),
        SelectableText( 
             token ,
             style: const  TextStyle( 
              fontSize: 16, 
               )
              ),
          ])
        
        
        ]
        )
        ),
      ),
       )   ); 
  }
}