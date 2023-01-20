import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/Roompages/roomByme.dart';
import 'package:revi/View/screens/Roompages/roombyothers.dart'; 


class RoomPage extends StatefulWidget {

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with SingleTickerProviderStateMixin {
  final colorstheme =const  Color(0xff4b4b87);

  TabController? _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const  Color.fromARGB(255, 228, 221, 221), 
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(
          'Rooms Page',
          style: TextStyle(fontSize: 16, color: colorstheme),
        ),
        centerTitle: true,
        shadowColor: const  Color.fromARGB(0, 136, 54, 54),
        leading: Padding(
          padding:  const EdgeInsets.only(left:15.0),
          child:  IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorstheme,
              size: 30,
            ),
           onPressed: () { 
                             Get.back() ;
                            },
          ),
        ), 
        actions: [ 
          IconButton(
            onPressed: (){ 

            },
             icon:const  Icon(Icons.logout_rounded)
             ) ,
          IconButton(
            onPressed: (() {
              
            }), 
            icon: const Icon(Icons.more_vert) 
            )
        ],
      ),
      body: Column(
        children: [ 
         const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300]),
            child: TabBar(
                isScrollable: true,
                indicatorPadding:const  EdgeInsets.all(10),
                labelColor: Colors.white,
                unselectedLabelColor:const  Color.fromARGB(223, 24, 109, 88),
                labelStyle:const  TextStyle(fontSize: 20),
                labelPadding:
                 const   EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                indicator: BoxDecoration(
                    color: Color.fromARGB(223, 24, 109, 88),
                    borderRadius: BorderRadius.circular(20)),
                controller: _tabController,
                tabs:const [
                  Text('Create Room'),
                  Text('Enter To Room'),
                  
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController, children: const[
              RoomPageBM() ,
              RoomPageBO()
          
            ]),
          )
        ],
      ),
    );
  }
}