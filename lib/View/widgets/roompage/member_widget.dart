import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revi/View/styles/styles.dart';
import 'package:revi/model/chatuser.dart';

import '../../styles/colors.dart';

class MemberWidget extends StatelessWidget {
  const MemberWidget({super.key, required this.user, required this.isAdmin});
   final ChatUser user ;
    final bool isAdmin ;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            user.image != ''
          ? CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.accentColor,
          backgroundImage:
          // ignore: unnecessary_null_comparison
          NetworkImage(user.image),
          // foregroundColor: Colors.red,
        )
            : const CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.accentColor,
            // foregroundColor: Colors.red,
            child: Center(
                child: Icon(CupertinoIcons.person) )) ,
            SizedBox(width: 15,) ,
            Text(
              user.name , 
              style: poppinsBold.copyWith(fontSize: 16),
            )
          ],

        ) ,
        isAdmin?  Card(
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
           ),
          color: Colors.green, 
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
                'Admin' ,
                 style: poppinsBold.copyWith(color: Colors.white ,fontSize: 10),


             ),
           )
        ): const SizedBox.shrink()
      ],
    );
  }
}