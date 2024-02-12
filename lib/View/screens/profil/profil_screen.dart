import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/controller/Roompaes_controller/roompage_controller.dart';
import 'package:revi/controller/auth/auth_controller.dart';   
import '../../../helper/dialog.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> { 
  final _formKey = GlobalKey<FormState>();
    
  String? _image;
  @override
  Widget build(BuildContext context) {  
    RoomPageControllerImp ctr = Get.put(RoomPageControllerImp()) ;  
    final usr = ctr.user ;  
    final username = Get.arguments[0] ; 
    final picture =Get.arguments[1] ;

    final  mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), 
      child: Scaffold( 
        appBar: AppBar(
          backgroundColor: themecolor,
          title: const Text(
            "Profile " , 
            style: TextStyle( 
           fontSize: 20
            ),
            ) 
            ) ,
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
                            ?//local image
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: Image.file(File(_image!),
                                    width: mq.height * .2,
                                    height: mq.height * .2,
                                    fit: BoxFit.cover)
                                    )
                            :

                         ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(mq.height * .1),
                                    child: CachedNetworkImage(
                                      width: mq.height * .2,
                                      height: mq.height * .2,
                                      fit: BoxFit.cover,
                                      imageUrl:  picture,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                              child: Icon(CupertinoIcons.person)),
                                    ),
                                  ) ,
                           

                        //edit image button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet(mq);
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

                    // user email label
                    Text( usr.email?? '',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16)),

                    // for adding some space
                    SizedBox(height: mq.height * .05),

                    // name input field
                    TextFormField( 
                    
                      initialValue:  username,
                      onSaved: (val) => AuthController.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                          
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color:themecolor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Foulen Foulani',
                          label: const Text('Name')),
                    ),

                    // for adding some space
                    SizedBox(height: mq.height * .02),

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
                          AuthController.updateUserInfo().then((value) {
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
          )),
    );
  } 
  
    void _showBottomSheet(Size mq ) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: mq.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          }); 

                          AuthController.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.add)), 

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          AuthController.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.add_a_photo_rounded) ),
                ],
              )
            ],
          );
        });
  }
  
  
  }

  // bottom sheet for picking a profile picture for user
  