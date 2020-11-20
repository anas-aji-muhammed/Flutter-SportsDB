
import 'package:fresh_food_store/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  ProductModel productModel;
  List _cartProducts = [].obs;
  final totalPrice = 0.0.obs;
  final cartEmptyOrNot = true.obs;

  addProducts(String name, double price, String pid, String imageUrl){
    cartEmptyOrNot.value = false;
    productModel = ProductModel(pid, price, name, imageUrl);
    addCartValue(price);
    _cartProducts.add(productModel);
  }

  List getProducts(){
    return _cartProducts;
  }

  removeProduct(int index, double price){
    reduceCartValue(price);
    _cartProducts.removeAt(index);
    if(_cartProducts.isEmpty){
      cartEmptyOrNot.value = true;
    }
  }

  addCartValue(double price){
    totalPrice.value = totalPrice.value + price;
  }

  reduceCartValue(double price){
    totalPrice.value = totalPrice.value - price;
  }

  getCartValue()=> totalPrice;

  clearCart(){
    _cartProducts.clear();
    totalPrice.value = 0;
    cartEmptyOrNot.value = true;
  }


}