  
  
  
  
  

import 'package:flutter/material.dart';



void showBottom(Size mq , BuildContext context , Function ontapCmaera ,Function ontapgellery) {
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
                        ontapgellery() ;
                    
                      },
                      child: const Icon(Icons.add)), 

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async { 
                        ontapCmaera() ;
                 
                      },
                      child: const Icon(Icons.add_a_photo_rounded) ),
                ],
              )
            ],
          );
        });
  }