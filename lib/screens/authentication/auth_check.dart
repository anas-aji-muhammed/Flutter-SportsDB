
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food_store/screens/authentication/sign_up.dart';
import 'package:fresh_food_store/screens/walkthrough/walkthrough.dart';
import 'package:get/get.dart';
import 'package:fresh_food_store/screens/home/home_page.dart';
class AuthenticationCheck extends StatefulWidget {
  @override
  _AuthenticationCheckState createState() => _AuthenticationCheckState();
}

class _AuthenticationCheckState extends State<AuthenticationCheck> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.data !=null){
            print(snapshot.data.uid);
            return HomePage();
          }
          return WalkThrough();
        }

        else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          }


        }
    );
  }
}

