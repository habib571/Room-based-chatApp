import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revi/View/screens/auth/signin_screen.dart';
import 'package:revi/View/screens/profil/profil_screen.dart';
import 'package:revi/constant/colors.dart';
import 'package:revi/controller/auth/auth_controller.dart';


import '../../widgets/roompage/drawerwidget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
        final  mq = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
      stream: AuthController.getUserInfo(),
      builder: (context, snapshot) {  

          if(snapshot.hasError) {
              return const Text('Something Went Wrong!' ,
              style: TextStyle( fontSize: 25) 
              ); 
              }  
              if(snapshot.connectionState==ConnectionState.waiting) { 
                return const CircularProgressIndicator();
            } 
         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>; 
         
        return ListView(
          padding: EdgeInsets.zero, 
          children: [  
            UserAccountsDrawerHeader( 
               decoration: const BoxDecoration(
                color: themecolor
               ),
            arrowColor: themecolor,
              accountName: Text( 
                  data['name'] ,
                style: const TextStyle(
                  fontSize: 17 , 
                  fontWeight: FontWeight.w500 ,
                  color: Colors.white
                ),
              ) ,
               accountEmail:Text( 
                   data['email'] ,
                  style: const TextStyle(
                  fontSize: 14 , 
                  fontWeight: FontWeight.w500 ,
                  color: Colors.white
                )) , 
              currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.cover,
                     imageUrl: data['image'] ,
                     errorWidget: (context, url, error) =>
                               const CircleAvatar(
                                          child: Icon(CupertinoIcons.person)),
                                        ),
                                      ) ,
              
              
              ) ,
                 DrawCard(
                icon:const Icon(Icons.person),
                 title: 'My profil',
                  ontap:() { 
                    Get.to(()=>const ProfilScreen( ) ,arguments: [data['name'] , data['image']] ) ;
                  }
                   ) ,
                   DrawCard(
                    title: 'Logout',
                     icon: const Icon(Icons.logout_outlined),
                      ontap: () async{ 
                        await AuthController.signOut() ; 
                        Get.off(()=> const LoginScreen()) ;
                        
                      }
                      )
    
    
            
          ],
        );
      }
    ) ;
  }
}