import 'package:get/get.dart' ; 
import 'package:shared_preferences/shared_preferences.dart'; 
class Myservices extends GetxService { 
  late SharedPreferences sharedPreferences ; 
   Future<Myservices>  init() async { 
    sharedPreferences = await SharedPreferences.getInstance() ; 
    return this ;

   }


} 
initialservices() async {
 await Get.putAsync(() => Myservices().init()) ;

}