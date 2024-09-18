import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/home.dart';
import 'dart:developer';
import 'dart:io';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
import '../../../controller/Roomscontroller/roompage_controller.dart';
import '../../../controller/Roomscontroller/validator.dart';
import 'package:image_picker/image_picker.dart';

import '../profil/modalbuttom.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final RoomPageControllerImp _controller = Get.put(RoomPageControllerImp());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primaryColor,
        ),
        title: Text(
          'Create Chat Room',
          style:
              poppinsBold.copyWith(color: AppColors.primaryColor, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              _controller.imageUrl == null
                  ? const CircleAvatar(
                      radius: 55,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 50,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: Image.file(File(_controller.imageUrl!),
                          width: mq.height * .2,
                          height: mq.height * .2,
                          fit: BoxFit.cover)),

              //edit image button
               Positioned(
                top: 0,
                right: 0,
                left: 70,
                child:  MaterialButton(
                  elevation: 1,
                  onPressed: () {
                    showBottom(mq, context, () async {
                      final ImagePicker picker = ImagePicker();

                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera);
                      if (image != null) {
                        log('Image Path: ${image.path}');
                        setState(() {
                          _controller.imageUrl = image.path;
                        });


                        // for hiding bottom sheet
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    }, () async {
                      final ImagePicker picker = ImagePicker();


                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        log('Image Path: ${image.path}');
                        setState(() {
                          _controller.imageUrl = image.path;
                        });

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
          const SizedBox(
            height: 15,
          ),
          Text(
            'Upload Image (Optional)',
            style: poppinsSemiBold.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Groupe name ',
                  style: poppinsBold.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (val) {
                    return validInput(val!, 3, 12, "roomname");
                  },
                  controller: _controller.roomname,
                  decoration: InputDecoration(
                    hintStyle: poppinsMedium.copyWith(fontSize: 13),
                    hintText: "exp :friends",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: AppColors.accentColor,
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.create();
                        _controller.imageUrl = null ;
                        Get.to(()=>Homepage()) ;
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          backgroundColor: AppColors.primaryColor),
                      child: Text("Create",
                          style: poppinsBold.copyWith(
                              color: Colors.white, fontSize: 15)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
