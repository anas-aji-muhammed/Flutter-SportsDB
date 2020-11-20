import 'package:flutter/material.dart';
import 'package:fresh_food_store/state_manage/cart_state.dart';
import 'package:get/get.dart';

import 'check_out.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cart(),
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}
String dateToday;
class _CartState extends State<Cart> {
final cart = Get.put(CartController());
List products;
  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    dateToday = date.toString().split(" ")[0];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: GetX<CartController>(
              init: cart,
              builder: (_cartState){
                products = _cartState.getProducts();
                if(products.length != 0){
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*.9,

                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index){
                          return Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.green[100]
                                    ),
                                    width: MediaQuery.of(context).size.width*.9,
                                    height: 120,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          (products[index].imageUrl != null) ? Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(products[index].imageUrl))
                                              : Icon(Icons.shopping_cart),
                                          Text(products[index].name),
                                          Text('₹ ${products[index].price.toString()}/Kg'),
                                          GestureDetector(
                                            child: Icon(Icons.delete),
                                            onTap: (){
                                              cart.removeProduct(index, products[index].price);
                                              setState(() {

                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please add items to cart"),
                      FlatButton(onPressed: ()=> Get.back(), 
                          child: Text("Shop Now"))
                    ],
                  ),
                );

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.5,
                  color: Colors.green,
                  child: FlatButton(
                      onPressed: (){
                        if(products.length != 0){
                          Get.to(ProductsCheckOut());
                        }
                      },
                      child: Text("Check Out")),
                ),
                SizedBox(
                  width: 5,
                ),
                Obx(
                    (){
                     return Text("Total : ₹ ${cart.getCartValue()}", style: TextStyle(
                       fontSize: 20
                     ),);
                    }
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}