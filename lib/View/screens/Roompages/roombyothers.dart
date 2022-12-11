import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';



import 'package:revi/View/screens/Roompages/createroom_button.dart';
import 'package:revi/View/widgets/roompage/RommBo_widget.dart';
import 'package:revi/View/widgets/roompage/RoomBM_widget.dart';  

import 'package:revi/View/widgets/roompage/textformfield.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart'; 
import 'package:revi/controller/Roompaes_controller/validator.dart';
import 'package:revi/data/datasource/local_storage/lcoal_storage_respostior.dart'; 
import 'package:revi/model/token.dart';


 class RoomPageBO extends StatefulWidget {
  const RoomPageBO({super.key});

  @override
  State<RoomPageBO> createState() => _RoomPageBOState();
}
 
class _RoomPageBOState extends State<RoomPageBO> {   
  GeneratedToken token = GeneratedToken() ; 
  
 
  GlobalKey<FormState> formstate= GlobalKey<FormState>();   
  RoomPageControllerImp roomPageController = Get.put(RoomPageControllerImp()) ;  
  final _mybox = Hive.box("mybox") ; 
  RoomsDataBase db =RoomsDataBase() ; 
 @override 
  void initState() {
    
     if(_mybox.get("RoomsList") ==null ) {
      db.createInitialData() ;
     }  
     else {
      db.GetData();
     }
      super.initState() ; 
  }


 
  

int num = 0;
String passwod ="" ;
String name ="" ;

  Future <String?>openDialog()=>showDialog<String>(context: context, builder: (context)=>AlertDialog(
    title: const Text("Enter To Room"),
    content: 
  CustomTextForm(
    hinttext: "Enter Romm's Token",
     mycontroller: roomPageController.roomname,
      valid: (val) {
        return validInput(val!, 0, 20, "roomname");
        }
      
      
      ),
  





    /*TextField(
      decoration: const InputDecoration(hintText: "Enter your room name"),
      controller:roomPageController.roomname,   
      
    ),*/ 
    actions: [
      TextButton( 
       
        onPressed:create  ,
        child: const Text("OK"))
         ],
     ),
     );
//____________________________________________




  Future<void> create() async { 
   
  Navigator.of(context).pop(roomPageController.roomname.text);   


  setState(()   {  
     
    name=(roomPageController.roomname).text;   
     passwod = token.GenToken(); 
    db.roomsList.add([name, passwod]) ;
    roomPageController.roomname.clear();   
      db.Updatedatabase() ; 
 
  } );  
  
  db.Updatedatabase() ; 
  
   } 
   void deleteRoom(int index) {
    setState(() {
      db.roomsList.removeAt(index);
    });
    db.Updatedatabase();
  } 

  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      floatingActionButton: createroombutton(onPressed: () {
        openDialog();
      },),

       body:   
        ListView.builder( 
        itemCount: db.roomsList.length,   
        itemBuilder: (context, index) {
          return RoomCardBO(
            height: 250,
             width: 250, 
             text:  db.roomsList[index][0] , 
             token: db.roomsList[index][1], 
           
          );
           
        },
        

        
          
        
        
        )

     );
  }
}




