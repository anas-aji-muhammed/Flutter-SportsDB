import 'package:flutter/material.dart';
import 'package:fresh_food_store/screens/home/cart_page.dart';
import 'package:fresh_food_store/state_manage/cart_state.dart';
import 'package:fresh_food_store/state_manage/product_select_state.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final productSelectState = Get.put(ProductSelectState());
  String dropdownValue = 'Normal';
  final cart = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetX<ProductSelectState>(
          init: productSelectState,
          builder: (_){
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.5,
                      decoration: BoxDecoration(
                          color: Color(0xffC4D4A3)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
                          Spacer(),
                          Icon(Icons.shopping_cart, color: Colors.black,)
                        ],
                      ),
                    ),

                    Positioned(
                      top: 130.0,
                      left: 100.0,
                      child: Image.network(
                        productSelectState.image.value,
                        fit: BoxFit.contain,
                        ),
                    ),

                  ],
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:25.0, right: 25.0, top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: GestureDetector(
                                        child: Icon(Icons.remove, color: Colors.grey,),
                                      onTap: (){
                                          productSelectState.decreaseWeight();
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${productSelectState.kg.value} Kg", style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'OpenSans'
                                  ),),
                                  SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        productSelectState.increaseWeight();
                                      },
                                        child: Icon(Icons.add, color: Colors.grey,)
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text("₹ ${productSelectState.price.value}", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'OpenSans-Bold'
                              ),),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                              productSelectState.name.value,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                hint: Text("Please Select the desired Addon"),
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.green,
                                  fontWeight: FontWeight.bold
                                ),
                                underline: Container(
                                  height: 2,

                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>['Normal','Cleaned + ₹20','Cleaned and Seasoned  + ₹30']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: (){
                              cart.addProducts(productSelectState.name.value, productSelectState.price.value,
                                  productSelectState.pid.value, productSelectState.image.value);
                              Get.off(CartScreen());
                            },
                            child: Container(
                              height: 50,
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.shopping_basket, color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("Bag it", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans-Bold'
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )
    );
  }
}
