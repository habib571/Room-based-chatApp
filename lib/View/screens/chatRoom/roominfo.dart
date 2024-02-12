import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constant/colors.dart';
import '../../../controller/Roompaes_controller/roompage_controller.dart';

import '../../../helper/dialog.dart';
import '../../../model/Room.dart';
import '../profil/modalbuttom.dart';

class RoomInfo extends StatefulWidget {
  const RoomInfo({
    super.key , 
    required this.room

    });
  final Room room ;
  @override
  State<RoomInfo> createState() => _RoomInfoState();
} 


class _RoomInfoState extends State<RoomInfo> {
 RoomPageControllerImp ctr = Get.put(RoomPageControllerImp()) ; 
  final _formKey = GlobalKey<FormState>(); 
  late TextEditingController _token ;
  late TextEditingController _name ;
  String? _image;   
@override
  void initState() {
    _token =TextEditingController(text:widget.room.token ) ;
    _name =TextEditingController(text:widget.room.roomname) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) { 
    final  mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
       child: Scaffold(
        body: Form(  
          key: _formKey, 
          child:  Padding( 
             padding:const EdgeInsets.symmetric(horizontal: 50), 
             child: SingleChildScrollView( 
              child:  Column(
                children: [  
                 const SizedBox(height: 30,) ,
                  //user profile picture
                Stack(
                  children: [ 
                    _image != null
                        ?

                        //local image
                        ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * .1),
                            child: Image.file(File(_image!),
                                width: mq.height * .2,
                                height: mq.height * .2,
                                fit: BoxFit.cover)
                                )
                        :   
                      CircleAvatar( 
                       radius: 60,
                       backgroundColor: Colors.grey.shade300,  
                            // ignore: unnecessary_null_comparison
                        backgroundImage:widget.room.image != null ? NetworkImage(widget.room.image) : null ,  
                                 // foregroundColor: Colors.red,
                        child:Center(
                           child: Text( 
                           widget.room.image =='' ?widget.room.roomname[0].toUpperCase()  : '' ,
                            style:const TextStyle( 
                            fontSize: 25), )
                            ) ,
                            
                            ) ,

                    /* ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: CachedNetworkImage(
                                  width: mq.height * .2,
                                  height: mq.height * .2,
                                  fit: BoxFit.cover,
                                  imageUrl:  widget.room.image,
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                          child: Icon(CupertinoIcons.person_3 , 
                                          color: Colors.blueAccent,
                                          )),
                                ),
                              ) */
                       

                    //edit image button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 40,
                      child: MaterialButton(
                        elevation: 1,
                        onPressed: () {
                           showBottom( 
                              mq ,
                             context, 
                             () async {
                                   final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                      ctr.updateRoomPicture(File(_image!), widget.room) ;
                          // for hiding bottom sheet
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                             } , 
                             () async{   
                                final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          ctr.updateRoomPicture(File(_image!) ,widget.room);
                          // for hiding bottom sheet
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);}


                             }

                              
                            ) ;
                        },
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: const Icon(Icons.edit, color: themecolor),
                      ),
                    )
                  ],
                ),

                // for adding some space
                SizedBox(height: mq.height * .03),

          

                // for adding some space
                SizedBox(height: mq.height * .05),

                // name input field
                TextFormField(
                
                   controller: _name,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color:themecolor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'eg. Classmates',
                      label: const Text('Room Name')),
                ),
                     SizedBox(height: mq.height * .03),
                   TextFormField(
                 
                   controller: _token,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color:themecolor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      //hintText: 'eg. Classmates',
                      label: const Text('Room Token')),
                ),

                // for adding some space
          

          // about input field
          

                // for adding some space
                SizedBox(height: mq.height * .05),

                // update profile button
                ElevatedButton.icon(
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themecolor,
                      shape: const StadiumBorder(),
                      minimumSize: Size(mq.width * .5, mq.height * .06)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                     ctr.updateRoominfo(widget.room ,_token.text , _name.text ).then((value) {
                        Dialogs.showSnackbar( 
                            context, 'Profile Updated Successfully!');
                      });
                    }
                  },
                  icon: const Icon(Icons.edit, size: 28),
                  label:
                      const Text('UPDATE', style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
          ),
       ),
    );
  }
}