
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food_store/notifications/notification_dart.dart';
import 'package:fresh_food_store/screens/authentication/auth_check.dart';
import 'package:fresh_food_store/screens/home/home_page.dart';
import 'package:fresh_food_store/screens/walkthrough/walkthrough.dart';
import 'package:fresh_food_store/services/storage_services.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Start(),
  ));
}
class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  Future<FirebaseApp> _initialization;
  final pushNotificationService = PushNotificationService();
  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    pushNotificationService.initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"),);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthenticationCheck();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(child: Text("Loading..."),),
        );
      },
    );
  }
}



