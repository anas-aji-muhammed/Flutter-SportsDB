import 'package:flutter/material.dart';
import 'package:fresh_food_store/animations/fade_animations.dart';
import 'package:fresh_food_store/screens/authentication/sign_in.dart';
import 'package:fresh_food_store/state_manage/auth_state.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignUpScreen());
  }
}

class SignUpScreen extends StatelessWidget {
  final authStateManage= Get.put(AuthStateController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                FadeAnimation(1, Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),)),
                SizedBox(height: 20,),
                FadeAnimation(1.2, Text("Create an account, It's free", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                ),)),
              ],
            ),
            Column(
              children: <Widget>[
                FadeAnimation(1.2, makeInput(label: "Name")),
                FadeAnimation(1.3, makeInput(label: "Mobile", type: TextInputType.name)),
              ],
            ),
            FadeAnimation(1.5, Container(
              padding: EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  authStateManage.authenticate();

                },
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              ),
            )),
            FadeAnimation(1.6, Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?"),
                GestureDetector(
                  child: Text(" Login", style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18
                  ),),
                  onTap: (){
                    Get.off(SignIn());
                  },
                ),
              ],
            )),
          ],
        ),
      ),

    );
  }

  Widget makeInput({label, obscureText = false, type = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          keyboardType:type,
          obscureText: obscureText,
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
        SizedBox(height: 30,),
      ],
    );
  }

  Widget OtpAlert({message, type}){
    return AlertDialog(
        title: Text(message),
        content: type == "Valid" ?
        Container(
          height: 150,
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
        )

            :Text("Oops")
    );
  }
}
