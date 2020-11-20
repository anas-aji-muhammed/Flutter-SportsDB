import 'package:flutter/material.dart';
import 'package:fresh_food_store/state_manage/auth_state.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authStateManage= Get.put(AuthStateController());

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: authStateManage.textEditingControllerOtp,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400])
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400])
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  authStateManage.smsCode = authStateManage.textEditingControllerOtp.text;
                  authStateManage.signInWithOTP();
                },
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Validate", style: TextStyle(
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
