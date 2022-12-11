import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';



import 'package:revi/View/screens/Roompages/createroom_button.dart';
import 'package:revi/View/widgets/roompage/RoomBM_widget.dart';  

import 'package:revi/View/widgets/roompage/textformfield.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart'; 
import 'package:revi/controller/Roompaes_controller/validator.dart';
import 'package:revi/data/datasource/local_storage/lcoal_storage_respostior.dart'; 
import 'package:revi/model/token.dart';


 class RoomPageBM extends StatefulWidget {
  const RoomPageBM({super.key});

  @override
  State<RoomPageBM> createState() => _RoomPageBMState();
}
 
class _RoomPageBMState extends State<RoomPageBM> {   
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
    db.roomsList.add([name, passwod]) ;
    roomPageController.roomname.clear();   
      db.Updatedatabase() ;  
      roomPageController.addroom(name ,passwod)  ;
 
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
          return RoomCardBM(
            height: 250,
             width: 250, 
             text:  db.roomsList[index][0] , 
             token: db.roomsList[index][1], 
             delete: (context)=> deleteRoom(index)
          );
           
        },
        

        
          
        
        
        )

     );
  }
}




