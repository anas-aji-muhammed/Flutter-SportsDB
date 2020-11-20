import 'package:flutter/material.dart';
import 'package:fresh_food_store/screens/products/fish_page.dart';
import 'package:fresh_food_store/screens/products/veg_page.dart';
import 'package:fresh_food_store/state_manage/cart_state.dart';
import 'package:get/get.dart';

import 'cart_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:HomePageScreen(),
    );
  }
}
class HomePageScreen extends StatefulWidget{
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with TickerProviderStateMixin{
  String offerImage = "assets/images/offers.jpg";
  final cart = Get.put(CartController());
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 8.0, right: 8.0),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Image.asset("assets/images/FreshRack_home.jpg"),
                  GestureDetector(
                      child: Icon(Icons.shopping_cart),
                    onTap: (){
                        Get.to(CartScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TabBar(
              controller: tabController,
                tabs:[
                  Tab(child: Text("Fish", style: TextStyle(color: Colors.black),),),
                  Tab(child: Text("Vegetables", style: TextStyle(color: Colors.black),),),
                ]
            )
          ),
          Expanded(
              child: TabBarView(
                controller: tabController,
                  children: [
                      FishScreen(),
                    VegScreen()
            ],
          )),
          Obx(
              (){
                return Opacity(
                  opacity: cart.cartEmptyOrNot.value != true? 1:0,
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.green,
                      child: Center(child: Text("Go to your fresh cart")),
                    ),
                    onTap: (){
                      Get.to(CartScreen());
                    },
                  ),

                );
              }
          )
        ],
      ),
    );
  }
}
