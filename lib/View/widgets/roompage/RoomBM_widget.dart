
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';   







 class RoomCardBM extends StatelessWidget{
  const RoomCardBM( {super.key, 
  required this.height ,  
  required this.width ,
   required this.text,  
   required this.token  ,
   required this.delete
  
  }
  );  
  
  final double height ;   
  final double width ;
  final String text ;  
  final String token ; 
  final Function(BuildContext) delete ; 



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 15 ,horizontal: 50) ,
      child :   
      InkWell( 
        onTap: () {
          
        },
      child :
      Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction( 
              
              onPressed: delete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(30),
            )
          ],
        
        ),
        
      child:
      
       Container(
        height:  height,                                                       //____ ELEMENTS__________
        width:  width,
        decoration: BoxDecoration(
          color:const Color.fromARGB(223, 24, 109, 88), 
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
     ) )); 
  }
}