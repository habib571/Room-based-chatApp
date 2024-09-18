import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/create_room_screen.dart';
import 'package:revi/View/screens/Roompages/join_room_screen.dart';
import 'package:revi/View/screens/drawer/homedrawer.dart';
import 'package:revi/View/styles/colors.dart';
import 'package:revi/View/styles/styles.dart';
//import 'package:revi/View/widgets/roompage/addroomwidget.dart';
import 'package:revi/View/widgets/roompage/conversation.dart';
import 'package:revi/constant/colors.dart';
import '../../../controller/Roomscontroller/roompage_controller.dart';
import '../../../controller/Roomscontroller/validator.dart';
import '../../../model/Room.dart';
import '../../widgets/roompage/textformfield.dart';
import 'createroom_button.dart';

class Homepage extends StatelessWidget {
  Homepage({
    super.key,
  });

  final RoomPageControllerImp _controller = Get.put(RoomPageControllerImp());

  List<Room> _list = [];

  Future<String?> dialogjoin(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Join Room'),
            content: CustomTextForm(
                hinttext: "Enter Token",
                mycontroller: _controller.verifToken,
                valid: (val) {
                  return validTokenInput(val!, _controller.checkToken());
                }),
            actions: [
              TextButton(
                  onPressed: () async {
                    await _controller.join();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text("join"))
            ],
          ));

  Future<String?> dialogcreate(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Create Room'),
            content: CustomTextForm(
                hinttext: "Enter Room's name ",
                mycontroller: _controller.roomname,
                valid: (val) {
                  return validInput(val!, 5, 12, "roomname");
                }),
            actions: [
              TextButton(
                  onPressed: () async {
                    await _controller.create();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(_controller.roomname.text);
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(color: themecolor),
                  ))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Createroombutton(
        onPressed: () async {
          //  dialogcreate(context);
          Get.defaultDialog(
              title: 'Create or Join ',
              titleStyle: robotoBold.copyWith(
                  color: AppColors.primaryColor, fontSize: 20),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(() => CreateRoomScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: AppColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Text("Create chat room",
                            style: poppinsBold.copyWith(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(()=> JoinRoomScreen()) ;
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: AppColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        child: Text("join chat room",
                            style: poppinsBold.copyWith(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
      drawer: const Drawer(
        //backgroundColor: themecolor,
        child: HomeDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Text('All Chat', style: poppinsBold.copyWith(fontSize: 19)),
        actions: [

          Image.asset(
            'assets/logo-small.png',
            height: 40,
            width: 60,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: GetBuilder<RoomPageControllerImp>(
            init: RoomPageControllerImp(),
            builder: (controler) {
              return StreamBuilder(
                stream: controler.getMyrooms(),
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
                          data?.map((e) => Room.fromJson(e.data())).toList() ??
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
                              return ConversationCard(
                                room: _list[index],
                              );
                            });
                      }

                      return const Center(
                        child: Text('No rooms Found !',
                            style: TextStyle(fontSize: 25)),
                      );
                  }
                }),
              );
            }),
      ),
    );
  }
}
