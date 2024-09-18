import 'package:flutter/material.dart';

import 'package:revi/View/widgets/roompage/materialButton.dart';
import 'package:revi/View/widgets/roompage/textformfield.dart';

class EnterToken extends StatelessWidget {
  final String text;
  const EnterToken({Key? key, required this.text}) : super(key: key);
  //TokenControllerImp controller =  Get.put(TokenControllerImp());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),

        height:
            300, //__________________ TEXTFORMFEILD OF THE TOKEN ____________________
        width: 300,

        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Text(text),
          CustomTextForm(
            valid: (val) {
              return null;
            },
            hinttext: "Enter Room's token",
            mycontroller: null,
          ),
          Materialbutton(
            text: "entrer",
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
