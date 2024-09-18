import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.hintText,
      required this.inputText,
      required this.textEditingController,
      required this.label})
      : super(key: key);
  final String hintText;
  final TextInputType inputText;
  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: TextField(
            controller: textEditingController,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            keyboardType: inputText,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(label),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                hintText: hintText,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2)))));
  }
}
