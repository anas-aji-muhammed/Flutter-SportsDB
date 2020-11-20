import 'package:get/get.dart';

class ProductSelectState extends GetxController{
  final name = "".obs;
  final image = "".obs;
  final pricePerKg = 0.0.obs;
  final pid = "0".obs;
  final price = 0.0.obs;
  final kg = 1.0.obs;
  updateValue(String namE, String img, double prc, String id){
    name.value = namE;
    image.value = img;
    pricePerKg.value = prc;
    pid.value = id;
    price.value = pricePerKg.value;
  }

  increaseWeight(){
    if(kg.value != 3){
      if(kg.value == 0.5){
        kg.value = 1.0;
        calculatePrice();
      }
      else{
        kg.value++;
        calculatePrice();
      }
    }
  }
  decreaseWeight(){
    if(kg.value >= 1){
     if(kg.value == 1){
       kg.value = 0.5;
       calculatePrice();
     }
    else{
       kg.value--;
       calculatePrice();
     }
    }

  }

  calculatePrice(){
    price.value = pricePerKg.value*kg.value;
  }


}