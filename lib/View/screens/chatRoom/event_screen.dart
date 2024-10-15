import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:revi/model/event.dart';

import '../../../controller/Roomscontroller/roompage_controller.dart';
import '../../../controller/chatRoom/chatRoom_controller.dart';
import '../../../model/Room.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import 'package:revi/model/message.dart';

class CreateEventScreen extends StatefulWidget {
    CreateEventScreen({super.key, required this.room, required this.isEdit ,this.event});
   final bool isEdit ;
  final Room room ;
  Event? event ;
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final ChatRoomcontroller _chtCtr  =Get.find() ;

  final RoomPageControllerImp _ctr = Get.find();
     DateTime selectedDate = DateTime.now() ;

   _selectDate(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: selectedDate, // Refer step 1
       firstDate: DateTime(2000),
       lastDate: DateTime(2025),
     );
     if (picked != null && picked != selectedDate) {
       String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
       setState(() {
         _ctr.dateController.text = formattedDate ;

       });
     }

   }
   TimeOfDay timeOfDay = TimeOfDay.now();
   _selectTime(BuildContext context) async {
     var time = await showTimePicker(
         context: context,
         initialTime: timeOfDay);

     if (time != null) {
       setState(() {
         _ctr.timeController.text = "${time.hour}:${time.minute}";
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new event',
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
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event Name' ,style: poppinsBold.copyWith(fontSize: 14),)  ,
            const SizedBox(height: 15,) ,
            TextFormField(
              controller:  widget.isEdit? TextEditingController(text: widget.event!.name) : _ctr.eventNameController,
              decoration: InputDecoration(
                hintText: "",
                hintStyle: poppinsMedium.copyWith(fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.accentColor,
                filled: true,

              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter valid name";
                }
                return null;
              },
            ),
            const SizedBox(height: 25,) ,
            Text('Event Date & Time' ,style: poppinsBold.copyWith(fontSize: 14),)  ,
            const SizedBox(height: 15,) ,
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    readOnly: true,
                    onTap: (){
                      _selectDate(context) ;
                    },
                    controller: widget.isEdit? TextEditingController(text: widget.event!.date) : _ctr.dateController ,
                    decoration: InputDecoration(
                      hintText: "",
                      hintStyle: poppinsMedium.copyWith(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppColors.accentColor,
                      filled: true,

                    ),
                  ),
                ),
                const SizedBox(width: 10) ,
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    onTap: (){
                      _selectTime(context) ;
                    },
                    controller: widget.isEdit? TextEditingController(text: widget.event!.time) : _ctr.timeController,
                    decoration: InputDecoration(
                      hintText: "",
                      hintStyle: poppinsMedium.copyWith(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppColors.accentColor,
                      filled: true,

                    ),
                  ),
                ),


              ],
            ),
            const SizedBox(height: 25,) ,
            Text('Event Location  ' ,style: poppinsBold.copyWith(fontSize: 14),)  ,
            const SizedBox(height: 15,) ,
            TextFormField(
              controller: widget.isEdit? TextEditingController(text: widget.event!.location) : _ctr.locationNameController,
              decoration: InputDecoration(
                hintText: "",
                hintStyle: poppinsMedium.copyWith(fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.accentColor,
                filled: true,

              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter valid name";
                }
                return null;
              },
            ),
            const SizedBox(height: 50,) ,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () async{
                   await _ctr.createEvent(widget.room.token) ;
                    _chtCtr.sendMessage(widget.room,  _ctr.eventNameController.text , Type.event) ;


                  } ,// Call the login method
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 30),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    "Create",
                    style: poppinsBold.copyWith(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    ) ;
  }
}
