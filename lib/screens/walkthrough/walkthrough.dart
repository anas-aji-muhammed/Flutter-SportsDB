import 'package:flutter/material.dart';
import 'package:fresh_food_store/models/slider_model.dart';
import 'package:fresh_food_store/screens/authentication/auth_check.dart';
import 'package:fresh_food_store/screens/authentication/sign_in_or_sign_up.dart';
import 'package:fresh_food_store/services/storage_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  List<SliderModel> _slides = new List<SliderModel>();

  int slideIndex = 0;

  PageController controller;
  StorageService storageService = StorageService();
  @override
  void initState() {
    controller = new PageController();
    _slides = getSlides();
    super.initState();
  }
  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              slideIndex = index;
            });
          },

          children: [
            SlideTile(
              imagePath: _slides[0].getImageAssetPath(),
              title: _slides[0].getTitle(),
              desc: _slides[0].getDesc(),
            ),
            SlideTile(
              imagePath: _slides[1].getImageAssetPath(),
              title: _slides[1].getTitle(),
              desc: _slides[1].getDesc(),
            ),
            SlideTile(
              imagePath: _slides[2].getImageAssetPath(),
              title: _slides[2].getTitle(),
              desc: _slides[2].getDesc(),
            ),
          ],
        ),
      ),
      bottomSheet: slideIndex != 2 ? Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: (){
                controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
              },
              splashColor: Colors.blue[50],
              child: Text(
                "SKIP",
                style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: Row(
                children: [
                  for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                ],),
            ),
            FlatButton(
              onPressed: (){
                print("this is slideIndex: $slideIndex");
                controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
              },
              splashColor: Colors.blue[50],
              child: Text(
                "NEXT",
                style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ): InkWell(
        onTap: (){
          print("Get Started Now");
          StorageService().updateIsNewUser("false");
          Get.off(SignInOrSignUp());
        },
        child: Container(
          height: MediaQuery.of(context).size.height*.2,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "GET STARTED NOW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}



class SlideTile extends StatefulWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  _SlideTileState createState() => _SlideTileState();
}

class _SlideTileState extends State<SlideTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(widget.imagePath),
          SizedBox(
            height: 40,
          ),
          Text(widget.title, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(widget.desc, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}

