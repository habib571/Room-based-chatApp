import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleP extends StatelessWidget {
  const ExampleP({super.key});

  @override
  Widget build(BuildContext context) {
    return  
    ChangeNotifierProvider(create: (context) => Data()  ,
     child:  Scaffold(
      body: Column(
        children: [  
          Consumer<Data>(
            builder: (context , model , widget) {
              return Text(model.name);
            }
          ) , 
          MaterialButton(onPressed: () { 
              
          } , 
           child:  const Text('do sqadazsf') 
           )
           
        ],
      ),
    ) 
    ) ;
    

  }
} 
class Data extends ChangeNotifier { 
  String name = 'welcome' ; 
   change() { 
     name= 'habib' ;  
     notifyListeners() ;
   }
   
} 