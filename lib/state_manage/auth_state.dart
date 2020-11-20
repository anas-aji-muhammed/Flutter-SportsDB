
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food_store/screens/authentication/auth_check.dart';
import 'package:fresh_food_store/screens/authentication/sign_in.dart';
import 'package:fresh_food_store/screens/home/home_page.dart';
import 'package:get/get.dart';
import 'package:fresh_food_store/screens/authentication/verifyOtp.dart';

class AuthStateController extends GetxController{
  String mobileNumber = "";
  String  smsCode, userName;
  var vId;

  TextEditingController textEditingControllerOtp = TextEditingController();

  final auth = FirebaseAuth.instance;
  // handleAuth() {
  //   return StreamBuilder<User>(
  //       stream: auth.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return HomePage();
  //         } else {
  //           return SignIn();
  //         }
  //       });
  // }

  //Sign out
  signOut() {
    auth.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    auth.signInWithCredential(authCreds);
    // handleAuth();
  }

  signInWithOTP() {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: vId, smsCode: smsCode);
    signIn(phoneAuthCredential);
    Get.to(AuthenticationCheck());

  }

  Future<void> authenticate() async {
    print("AuthService Called");
    print(mobileNumber);
    await auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: verificationCompleted ,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
  verificationCompleted(PhoneAuthCredential credential) async {
    print("Verification complete called");
    smsCode = textEditingControllerOtp.text;
    auth.signInWithCredential(credential);
    Get.to(AuthenticationCheck());

  }
  verificationFailed(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    print(e.message);

  }
  codeSent(String verificationId, int resendToken) {
    print("Codesent complete called");

    vId = verificationId;
    print(vId);

    Get.to(VerifyOtpScreen());


  }
  codeAutoRetrievalTimeout(String verificationId) {
    vId = verificationId;
    print(vId);
    print(verificationId);
    signInWithOTP();
  }


}