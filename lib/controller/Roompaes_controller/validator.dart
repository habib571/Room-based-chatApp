import 'package:get/get.dart';

validInput( String val,int min,int max,String type){
if(type=="roomname"){

if(!GetUtils.isUsername(val)){
  return "not valid room name";
}

}
 if(val.isEmpty){return "cannot be empty";}       //____________________CONDITION OF THE TEXTFORMFEILD_______________

} 

validTokenInput(String val, bool check) { 
 if(!check) { 
   return "Check Your token " ;
 }  
 if(val.isEmpty) { 
  return "Connot Be Empty" ;
 }

}