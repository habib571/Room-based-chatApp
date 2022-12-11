import 'package:get/get.dart';

validInput( String val,int min,int max,String type){
if(type=="roomname"){

if(!GetUtils.isUsername(val)){
  return "not valid room name";
}

}
 if(val.isEmpty){return "cannot be empty";}       //____________________CONDITION OF THE TEXTFORMFEILD_______________

}