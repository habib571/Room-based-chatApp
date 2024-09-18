import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revi/View/screens/chatRoom/update_info_screen.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/View/widgets/roompage/member_widget.dart';
import 'package:revi/model/chatuser.dart';

import '../../../controller/Roomscontroller/roompage_controller.dart';
import '../../../model/Room.dart';
import '../profil/modalbuttom.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key, required this.room});
  final Room room;
  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  RoomPageControllerImp ctr = Get.find();
 List<ChatUser> _list = [] ;
   String? _image;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Details',
          style: poppinsSemiBold.copyWith(
              color: AppColors.primaryColor, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: (() {
              Get.back();
            }),
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColors.primaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //user profile picture
            Center(
              child: Stack(
                children: [
                  _image != null
                      ?
                      //local image
                      ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * .1),
                          child: Image.file(File(_image!),
                              width: mq.height * .2,
                              height: mq.height * .2,
                              fit: BoxFit.cover))
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          // ignore: unnecessary_null_comparison
                          backgroundImage: widget.room.image != null
                              ? NetworkImage(widget.room.image)
                              : null,
                          // foregroundColor: Colors.red,
                          child: Center(
                              child: Text(
                            widget.room.image == ''
                                ? widget.room.roomname[0].toUpperCase()
                                : '',
                            style: const TextStyle(fontSize: 25),
                          )),
                        ),

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
                    top :0 ,
                    left: 40,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {
                        showBottom(mq, context, () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image =
                              await picker.pickImage(source: ImageSource.camera);
                          if (image != null) {
                            log('Image Path: ${image.path}');
                            setState(() {
                              _image = image.path;
                            });

                            ctr.updateRoomPicture(File(_image!), widget.room);
                            // for hiding bottom sheet
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }, () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image =
                              await picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            log('Image Path: ${image.path}');
                            setState(() {
                              _image = image.path;
                            });

                            ctr.updateRoomPicture(File(_image!), widget.room);
                            // for hiding bottom sheet
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        });
                      },
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: const Icon(Icons.edit, color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,) ,
            Center(
              child: Text(
                 widget.room.roomname ,
                style: poppinsMedium.copyWith(color: AppColors.primaryColor ,fontSize: 20),
              ),
            ) ,
            const SizedBox(height: 40,) ,
            ListTile(
              subtitle: Text(
                 'update groupe name and token ' ,
                style: poppinsSemiBold.copyWith(color: AppColors.secondaryTxtColor ,fontSize: 12),
              ) ,

              onTap: () {
                 Get.to(()=> RoomInfo(room: widget.room)) ;
              },
              title: Text(
                 'Edit Info' ,
                style: poppinsBold.copyWith(fontSize: 15),
              ),
              trailing: const Icon(Icons.edit ,color: AppColors.primaryColor,),
            ) ,
            ListTile(
              subtitle: Text(
                'Create new Event and share it with group members ' ,
                style: poppinsSemiBold.copyWith(color: AppColors.secondaryTxtColor ,fontSize: 12),
              ) ,

              onTap: () {
                Get.to(()=> RoomInfo(room: widget.room)) ;
              },
              title: Text(
                'Create new Event' ,
                style: poppinsBold.copyWith(fontSize: 15),
              ),
              trailing: const Icon(Icons.event ,color: AppColors.primaryColor,),
            ) ,
            ListTile(
              onTap: () {
                Get.to(()=> RoomInfo(room: widget.room)) ;
              },
              title: Text(
                'Media and files ' ,
                style: poppinsBold.copyWith(fontSize: 15),
              ),
              trailing: const Icon(Icons.perm_media_outlined ,color: AppColors.primaryColor,),
            ) ,
            Divider() ,
            Text(
           'Members' ,
              style: poppinsBold.copyWith(fontSize: 18),
            ),
        StreamBuilder(
          stream: ctr.getRoomUsers(widget.room.token),
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ));
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                _list =
                    data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                        [];
                if (kDebugMode) {
                  print(_list.length);
                }
                if (_list.isNotEmpty) {
                  return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xffCDD4D9),
                        thickness: 0.5,
                      ),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _list.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return MemberWidget(user: _list[index], isAdmin: widget.room.isUserAdmin && _list[index].id == ctr.user.uid ) ;
                      });
                }

                return const Center(
                  child: Text('No rooms Found !',
                      style: TextStyle(fontSize: 25)),
                );
            }
          }),
        )
          ],
        ),
      ),
    );
  }
}
