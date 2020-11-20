import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fresh_food_store/screens/products/product_details.dart';
import 'package:fresh_food_store/state_manage/cart_state.dart';
import 'package:fresh_food_store/state_manage/product_select_state.dart';
import 'package:get/get.dart';

class FishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FishProductsLoad(),
    );
  }
}

class FishProductsLoad extends StatefulWidget {
  @override
  _FishProductsLoadState createState() => _FishProductsLoadState();
}

class _FishProductsLoadState extends State<FishProductsLoad> {
  CollectionReference fishProducts =
      FirebaseFirestore.instance.collection('products-Fish');
  final cart = Get.put(CartController());
  final productSelectState = Get.put(ProductSelectState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: fishProducts.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("${snapshot.error}");
          return Scaffold(
            body: Center(
                child: Column(
              children: [
                Text("Something went wrong. Reload."),
                GestureDetector(
                  child: Icon(Icons.cached),
                  onTap: () {
                    setState(() {});
                  },
                )
              ],
            )),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print((snapshot.data.docs).length);
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: (snapshot.data.docs).length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data.docs[index].data()['resType'] == "add") {

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffECEDF1),

                    ),
                    width: 195,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 18, bottom: 18),
                      child: Column(
                        children: [
                          Text("A Spring Surprise", style: TextStyle(
                            fontFamily: "OpenSans",

                          ),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("40% OFF", style: TextStyle(
                                fontFamily: "OpenSans-Bold",
                                fontSize: 25
                            ),),
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.green)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("FOODLY SURPRISE", style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Use the code above for Spring collection purchases",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpenSans-Bold',
                            ),),
                        ],
                      ),
                    ),
                  );
                }
                else {

                  return GestureDetector(
                    onTap: (){
                      productSelectState.updateValue(snapshot.data.docs[index].data()['name'],
                          snapshot.data.docs[index].data()['image'],
                          double.parse(snapshot.data.docs[index].data()['price']),snapshot.data.docs[index].data()['pid']);
                      Get.to(ProductDetails());
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF7DFB9),
                            borderRadius: BorderRadius.circular(20.00)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Color(0XffFAF0DA),
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Icon(
                              //           Icons.add
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Center(
                                child: Image.network(
                                  snapshot.data.docs[index]
                                      .data()['image'],
                                  fit: BoxFit.contain,
                                  height: 150,
                                )
                              ),

                              Text(
                                snapshot.data.docs[index]
                                    .data()['name'],
                                style: TextStyle(
                                fontFamily: 'OpenSans-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),


                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            snapshot.data.docs[index]
                                                .data()['price'],
                                            style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("Per Kg", style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        ],
                                      ),
                                    //     RaisedButton(
                                    //       onPressed: () {
                                    //       cart.addProducts(
                                    //         snapshot.data.docs[index]
                                    //             .data()['name'],
                                    //         int.parse(snapshot.data.docs[index]
                                    //             .data()['price']),
                                    //         snapshot.data.docs[index]
                                    //             .data()['pid'],
                                    //         snapshot.data.docs[index]
                                    //             .data()['image']);
                                    //       },
                                    //     child: Text("Add to Cart"),
                                    // )

                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                    ),
                  );
                }
              },
              staggeredTileBuilder: (int index) => new StaggeredTile.count(
                  2,
                  snapshot.data.docs[index].data()['resType'] == "add"
                      ? 2
                      : 3),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
