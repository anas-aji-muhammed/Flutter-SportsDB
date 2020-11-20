import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food_store/models/product_model.dart';
import 'package:fresh_food_store/state_manage/cart_state.dart';
import 'package:get/get.dart';

class ProductsCheckOut extends StatefulWidget {
  @override
  _ProductsCheckOutState createState() => _ProductsCheckOutState();
}

class _ProductsCheckOutState extends State<ProductsCheckOut> {
  String mobile, totalCartValue, address;
  final cart = Get.put(CartController());
  var products;
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  TextEditingController mobileController, addressController;
  Map<String, dynamic> data;
  List<Map> productsList = [];
  getProductList(){
    for(int i=0; i<=products.length-1; i++){
      productsList.insert(i, {
        "productName" : products[i].name,
        "quantity" : products[i].quantity.toString(),
      });
    }
    updateOrderMap();
  }

  updateOrderMap(){

    data={
      "OrderedProducts" : productsList,
      "DeliveryAddress" : addressController.text
    };
    orderNow();
  }

  Future<void> orderNow() {
      return orders
        .doc(mobileController.text)
        .collection("myOrders")
        .doc(DateTime.now().toString())
        .set(data)
        .then(
              (value)
          {
            print("Products Added");
            cart.clearCart();
            Get.back();
          })
        .catchError((error) {
        print("Failed to add order: $error");
        Get.back();
        } );
  }
  @override
  void initState() {
    mobileController = TextEditingController();
    addressController = TextEditingController();
    products = cart.getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Total : ₹ ${cart.getCartValue()}", style: TextStyle(
            fontSize: 20
            ),),
              Divider(),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                    hintText: "Enter Your Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.00),

                    )
                ),
                keyboardType: TextInputType.number,
              ),
              Divider(),
              Container(
                child: TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: "Delivery Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.00),

                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  getProductList();
                  Get.back();
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Buy Now", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
