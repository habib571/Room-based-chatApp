import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';



import 'package:revi/View/screens/Roompages/createroom_button.dart';
import 'package:revi/View/widgets/roompage/Room_widget.dart';  

import 'package:revi/View/widgets/roompage/textformfield.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart'; 
import 'package:revi/controller/Roompaes_controller/validator.dart';
import 'package:revi/data/datasource/local_storage/lcoal_storage_respostior.dart'; 
import 'package:revi/model/token.dart';

import '../../../model/Room.dart';


 class RoomPageBM extends StatefulWidget {
  const RoomPageBM({super.key  ,
       
  });


  @override
  State<RoomPageBM> createState() => _RoomPageBMState();
}
 
class _RoomPageBMState extends State<RoomPageBM> {   
  GeneratedToken token = GeneratedToken() ; 
  
 
  GlobalKey<FormState> formstate= GlobalKey<FormState>();   
  RoomPageControllerImp roomPageController = Get.put(RoomPageControllerImp()) ;  
  
 
 
 


int num = 0;
String passwod ="" ;
String name ="" ;
 List<Room> _list = [] ;
  Future <String?>openDialog()=>showDialog<String>(context: context, builder: (context)=>AlertDialog(
    title: const Text("The room name"),
    content: 
  CustomTextForm(
    hinttext: "Enter Romm's name ",
     mycontroller: roomPageController.roomname,
      valid: (val) {
        return validInput(val!, 5, 12, "roomname");
        }
      
      
      ),
  





    /*TextField(
      decoration: const InputDecoration(hintText: "Enter your room name"),
      controller:roomPageController.roomname,   
      
    ),*/ 
    actions: [
      TextButton( 
       
        onPressed:create  ,
        child: const Text("Create"))
         ],
     ),
     );
//____________________________________________




  Future<void> create() async { 
   
  Navigator.of(context).pop(roomPageController.roomname.text);   


  setState(()   {   
     
    name=(roomPageController.roomname).text;   
     passwod = token.GenToken(); 
    roomPageController.roomname.clear();   
    
      roomPageController.addroom(name ,passwod)  ;
 
  } );  
  
  
  
   } 
   

  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      floatingActionButton: createroombutton(onPressed: () {
        openDialog();
      },),

      body: StreamBuilder(
          stream: roomPageController.getRoomAdmin(),  
          builder: ((context, snapshot) {  
            
            switch(snapshot.connectionState) { 
              
              case ConnectionState.waiting:
                        case ConnectionState.none:
                         return const Center(
                          child: CircularProgressIndicator());

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done: 
                         final data = snapshot.data?.docs ; 
                         _list = data?.map((e) => Room.fromJson(e.data()) ).toList() ??[] ; 
                          
                            
                             if(_list.isNotEmpty)  { 
                              return

                           ListView.builder( 
                            physics: const BouncingScrollPhysics(), 
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                               return RoomCard(room: _list[index]) ;

                            }

                          ); 
                             
                  
                         
            }         
            else {  
              return const Center( 
                child: Text('No rooms Found !' ,
                 style:  TextStyle( fontSize: 25)
                  ),
              );

            } 
            
    }  }),
      ) ,
        

        
          
        
        
        

     );
  }
}




