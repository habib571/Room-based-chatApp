import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/drawer/homedrawer.dart';
//import 'package:revi/View/widgets/roompage/addroomwidget.dart';
import 'package:revi/View/widgets/roompage/conversation.dart';
import 'package:revi/constant/colors.dart';
import '../../../controller/Roompaes_controller/roompage_controller.dart';
import '../../../controller/Roompaes_controller/validator.dart';
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
      floatingActionButton: Createroombutton(
        onPressed: () async {
          dialogcreate(context);
        },
      ),
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(
        //backgroundColor: themecolor,
        child: HomeDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: themecolor,
        toolbarHeight: 60,
        title: const Text(
          'All Chat',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                dialogjoin(context);
              },
              icon: const Icon(Icons.person_add_alt_1_outlined))
        ],
      ),
      body: GetBuilder<RoomPageControllerImp>(
          init: RoomPageControllerImp(),
          builder: (controler) {
            return StreamBuilder(
              stream: controler.getMyrooms(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());

                  //if some or all data is loaded then show it
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
                      return ListView.builder(
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
    );
  }
}
