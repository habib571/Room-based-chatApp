import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/home.dart';

import '../../../controller/Roomscontroller/roompage_controller.dart';
import '../../../controller/Roomscontroller/validator.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class JoinRoomScreen extends StatelessWidget {
  JoinRoomScreen({super.key});
  final RoomPageControllerImp _controller = Get.put(RoomPageControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => Homepage());
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primaryColor,
        ),
        title: Text(
          'Join Chat Room',
          style:
              poppinsBold.copyWith(color: AppColors.primaryColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40,) ,
            Text(
              'Token',
              style: poppinsBold.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (val) {
                return validTokenInput(val!, _controller.checkToken());
              },
              controller: _controller.verifToken,
              decoration: InputDecoration(
                hintStyle: poppinsMedium.copyWith(fontSize: 13),
                hintText: "Enter token",
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
                  onPressed: () async {
                    await _controller
                        .join()
                        .then((value) => Get.to(() => Homepage()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      backgroundColor: AppColors.primaryColor),
                  child: Text("Join",
                      style: poppinsBold.copyWith(
                          color: Colors.white, fontSize: 15)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
