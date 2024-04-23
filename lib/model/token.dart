import 'dart:math' ; 
class GeneratedToken { 
  
 static String genToken() {
  String token = '' ; 
  String letters ='azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN' ; 
  String numbers = '123456789' ; 

  for(int i=0 ;i<4 ; i++) {
    var rand = Random() ;  
    token += letters.split('')[rand.nextInt(letters.length) ] ; 
    token += numbers.split('') [rand.nextInt(numbers.length) ] ;
   // token += special.split('')[rand.nextInt(special.length) ] ;
    
  }


  return token ; 
  }

}  