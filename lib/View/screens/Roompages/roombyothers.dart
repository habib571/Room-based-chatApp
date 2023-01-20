import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:revi/View/screens/Roompages/createroom_button.dart';
import 'package:revi/View/widgets/roompage/textformfield.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart'; 
import 'package:revi/controller/Roompaes_controller/validator.dart';
import 'package:revi/data/datasource/local_storage/lcoal_storage_respostior.dart'; 
import 'package:revi/model/token.dart';

import '../../../model/Room.dart';
import '../../widgets/roompage/Room_widget.dart';


 class RoomPageBO extends StatefulWidget {
  const RoomPageBO({super.key});

  @override
  State<RoomPageBO> createState() => _RoomPageBOState();
}
 
class _RoomPageBOState extends State<RoomPageBO> {   
  GeneratedToken token = GeneratedToken() ; 
  
 
  GlobalKey<FormState> formstate= GlobalKey<FormState>();   
  RoomPageControllerImp roomPageController = Get.put(RoomPageControllerImp()) ;  
   
 
  

int num = 0;
String passwod ="" ;
String name ="" ; 
String verifTkn ='' ; 
List<Room> _list =[] ;

  Future <String?>openDialog()=>showDialog<String>(context: context, builder: (context)=>AlertDialog(
    title: const Text("Join  Room"),
    content: 
  CustomTextForm(
    hinttext: "Enter Romm's Token",
     mycontroller: roomPageController.verifToken, 
     
      valid: (val) {    
     

    
      }
      
      ),
  
    actions: [
      TextButton( 
       
        onPressed:join  ,
        child: const Text("OK"))
         ],
     ),
     );
//____________________________________________




  Future<void>  join() async { 
   
  Navigator.of(context).pop(roomPageController.roomname.text);   


  setState(()   {  
   
    verifTkn =(roomPageController.verifToken).text ; 
     roomPageController.gettVerif(verifTkn) ;

    roomPageController.verifToken.clear();   
 
 
  } );  
  

  
   } 
   

  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      floatingActionButton: createroombutton(onPressed: () {
        openDialog();
      },),

       body: StreamBuilder(
          stream: roomPageController.getRoomJoined(),  
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




